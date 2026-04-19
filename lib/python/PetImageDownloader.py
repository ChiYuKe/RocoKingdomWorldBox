import os
import json
import time
import random
import httpx
from bs4 import BeautifulSoup
from concurrent.futures import ThreadPoolExecutor


class PetImageDownloader:
    def __init__(self, json_file='pets.json'):
        self.json_file = json_file
        self.base_dir = 'pet_resources'
        self.sub_dirs = {1: "normal", 2: "shiny", 3: "fruit", 4: "egg", 5: "trait"}
        self.type_name_map = {"normal": 1, "shiny": 2, "fruit": 3, "egg": 4, "trait": 5}

        for d in self.sub_dirs.values():
            os.makedirs(os.path.join(self.base_dir, d), exist_ok=True)

        # 调高了超时时间，改为 60 秒更稳妥
        self.client = httpx.Client(http2=True, timeout=60.0, follow_redirects=True)
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
            'Referer': 'https://wiki.biligame.com/rocom/'
        }
        self.url_to_ids = {}

    def _download_file(self, url, save_path, retries=3):
        """核心下载函数：增加重试机制"""
        if not url: return False
        if os.path.exists(save_path): return True  # 已存在跳过

        for attempt in range(retries):
            try:
                resp = self.client.get(url)
                if resp.status_code == 200:
                    with open(save_path, 'wb') as f:
                        f.write(resp.content)
                    return True
                elif resp.status_code == 404:
                    return False  # 404 不需要重试
            except Exception:
                pass

            # 如果失败了，等待一下再重试，时间随次数递增
            time.sleep(attempt + 1)

        print(f"  [严重错误] 最终下载失败: {save_path}")
        return False

    def scan_detail_page(self, pet, retries=2):
        """第一阶段：扫描详情页（增加基础重试）"""
        pet_id = pet.get('id')
        url = pet.get('detail_url')
        if not pet_id or not url: return None

        for attempt in range(retries):
            try:
                # 随机延迟，防止请求过快
                time.sleep(random.uniform(0.3, 0.8))
                resp = self.client.get(url, headers=self.headers)

                if resp.status_code != 200:
                    continue

                soup = BeautifulSoup(resp.text, 'html.parser')
                pet_task = {"id": pet_id, "imgs": {}}

                # 1. 扫描 1-4 号位
                img_container = soup.find('div', class_='rocom_sprite_grament_img')
                if img_container:
                    for i in [1, 2, 3, 4]:
                        li = img_container.find('li', id=f'receptor_grament_list_{i}')
                        img = li.find('img') if li else None
                        if img and img.get('src'):
                            src = 'https:' + img['src'] if img['src'].startswith('//') else img['src']
                            pet_task["imgs"][i] = src
                            if src not in self.url_to_ids: self.url_to_ids[src] = []
                            self.url_to_ids[src].append(pet_id)

                # 2. 扫描特性图
                trait_box = soup.find('div', class_='rocom_sprite_temp_characteristic_box')
                if trait_box:
                    t_img = trait_box.find('img')
                    if t_img and t_img.get('src'):
                        t_src = 'https:' + t_img['src'] if t_img['src'].startswith('//') else t_img['src']
                        pet_task["imgs"][5] = t_src
                        if t_src not in self.url_to_ids: self.url_to_ids[t_src] = []
                        self.url_to_ids[t_src].append(pet_id)

                return pet_task
            except Exception as e:
                if attempt == retries - 1:
                    print(f"扫描 {pet_id} 彻底失败: {e}")
                time.sleep(1)
        return None

    def start(self, threads=8, target_types=None):
        target_indices = None
        if target_types:
            target_indices = [self.type_name_map[t] for t in target_types if t in self.type_name_map]

        if not os.path.exists(self.json_file):
            print("错误：找不到数据文件")
            return

        with open(self.json_file, 'r', encoding='utf-8') as f:
            pets = json.load(f)

        print(f"🚀 第一阶段：正在扫描详情页并构建命名关系...")
        with ThreadPoolExecutor(max_workers=threads) as executor:
            all_tasks = list(filter(None, executor.map(self.scan_detail_page, pets)))

        print(f"📥 第二阶段：执行下载 (包含重试逻辑)...")
        # 由于下载可能涉及文件 IO 冲突，这里单线程循环触发，内部 download 是安全的
        for task in all_tasks:
            pid = task["id"]
            for i, url in task["imgs"].items():
                if target_indices and i not in target_indices:
                    continue

                # 命名逻辑
                if i in [3, 4]:
                    final_id = max(self.url_to_ids[url])
                elif i == 5:
                    final_id = min(self.url_to_ids[url])
                else:
                    final_id = pid

                if i == 1:
                    filename = f"pet_{final_id}.png"
                elif i == 2:
                    filename = f"pet_{final_id}_s.png"
                elif i == 3:
                    filename = f"pet_{final_id}_f.png"
                elif i == 4:
                    filename = f"pet_{final_id}_e.png"
                elif i == 5:
                    filename = f"ability_{final_id}.png"

                save_path = os.path.join(self.base_dir, self.sub_dirs[i], filename)

                if self._download_file(url, save_path):
                    # 只有真正写入文件的才打印，减少刷屏
                    pass

        print("\n✅ 任务处理完毕！")


if __name__ == "__main__":
    downloader = PetImageDownloader('pets.json')
    # 示例：只下载果实和蛋
    # downloader.start(threads=10, target_types=["fruit", "egg"])
    downloader.start(threads=10, target_types=["shiny"])
    # 下载全部 (不传 target_types 即可)
    # downloader.start(threads=10)