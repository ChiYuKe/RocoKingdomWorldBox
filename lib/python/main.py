import json
from bs4 import BeautifulSoup
import re

class RocomFullParser:
    def __init__(self, file_path='wiki.html'):
        self.file_path = file_path

    def get_original_image(self, thumb_url):
        """还原大图链接逻辑"""
        if not thumb_url or '/thumb/' not in thumb_url:
            return thumb_url
        try:
            parts = thumb_url.split('/thumb/')
            prefix = parts[0]
            rest = parts[1]
            real_path = rest[:rest.rfind('/')]
            return f"{prefix}/{real_path}"
        except:
            return thumb_url

    def parse(self):
        try:
            with open(self.file_path, 'r', encoding='utf-8') as f:
                content = f.read()

            soup = BeautifulSoup(content, 'html.parser')
            pets = []

            # 定位所有编号块 (block_1)
            id_nodes = soup.find_all('p', class_=re.compile(r'block_1'))
            print(f"开始解析详细数据，共发现 {len(id_nodes)} 个卡片...")

            for p_id in id_nodes:
                # 1. 提取 ID
                spirit_id = p_id.get_text(strip=True).upper().replace('NO.', '').strip()

                # 提取详细界面链接 (从 block_1 内部的 a 标签获取)
                a_tag = p_id.find('a')
                detail_link = ""
                if a_tag:
                    href = a_tag.get('href', '')
                    if href.startswith('http'):
                        detail_link = href
                    else:
                        detail_link = f"https://wiki.biligame.com{href}"

                # 提取名字 (从随后的 block_2 获取)
                p_name = p_id.find_next('p', class_=re.compile(r'block_2'))
                spirit_name = p_name.get_text(strip=True) if p_name else "未知"

                # 提取图片
                parent_div = p_id.parent
                img_tag = parent_div.find('img', class_='rocom_prop_icon')

                img_small = ""
                img_large = ""

                if img_tag:
                    # 优先从 srcset 获取远程地址
                    srcset = img_tag.get('srcset', '')
                    if srcset:
                        # 选取最后一份高清地址
                        img_small = srcset.split(',')[-1].strip().split(' ')[0]
                    else:
                        img_small = img_tag.get('src', '')

                    if img_small.startswith('//'):
                        img_small = 'https:' + img_small

                    img_large = self.get_original_image(img_small)

                # 将 link 加入字典
                pets.append({
                    "id": spirit_id,
                    "name": spirit_name,
                    "img_small": img_small,
                    "img_large": img_large,
                    "detail_url": detail_link  # 详细界面链接
                })

            # 去重处理
            unique_pets = {p['id'] + p['name']: p for p in pets}
            result = list(unique_pets.values())
            result.sort(key=lambda x: x['id'])

            # 导出为 JSON
            with open('pets.json', 'w', encoding='utf-8') as f:
                json.dump(result, f, ensure_ascii=False, indent=4)

            print("-" * 30)
            print(f"成功导出包含详细链接的 JSON 文件！")
            if result:
                print(f"示例数据: {result[0]['name']} -> {result[0]['detail_url']}")

        except Exception as e:
            print(f"解析出错: {e}")


if __name__ == "__main__":
    parser = RocomFullParser('wiki.html')
    parser.parse()