import httpx
from bs4 import BeautifulSoup
import json
import re
import time
import random
import os


class RocomRescuer:
    def __init__(self, input_file='pets.json', output_file='pets_full.json'):
        self.input_file = input_file
        self.output_file = output_file
        self.ability_dir = 'ability_images'
        os.makedirs(self.ability_dir, exist_ok=True)

        self.client = httpx.Client(http2=True, timeout=30.0, follow_redirects=True)
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
            'Referer': 'https://wiki.biligame.com/rocom/'
        }

        # 中文系别到英文的映射表
        self.type_map = {
            "火": "Fire", "水": "Water", "草": "Grass", "光": "Light",
            "普通": "Normal", "龙": "Dragon", "毒": "Poison", "虫": "Bug",
            "武": "Fight", "翼": "Wing", "萌": "Cute", "恶": "Evil",
            "机械": "Machine", "幻": "Magic", "电": "Electric", "幽": "Ghost",
            "地": "Ground", "冰": "Ice", "石": "Rock"
        }

        # 记录图片URL对应的首发ID及所有关联ID
        self.ability_registry = {}

    def _download_ability_image(self, url, first_id):
        filename = f"ability_{first_id}.png"
        path = os.path.join(self.ability_dir, filename)
        if os.path.exists(path): return filename

        try:
            resp = self.client.get(url, headers=self.headers)
            if resp.status_code == 200:
                with open(path, 'wb') as f:
                    f.write(resp.content)
                return filename
        except Exception as e:
            print(f"特性图片下载失败: {e}")
        return ""

    def parse_detail_page(self, pet):
        url = pet.get('detail_url')
        if not url: return pet

        for attempt in range(3):
            try:
                time.sleep(random.uniform(2, 4)) # 稍微快一点，但保持安全
                response = self.client.get(url, headers=self.headers)
                if response.status_code != 200: continue

                soup = BeautifulSoup(response.text, 'html.parser')

                pet['types'] = []
                attr_container = soup.find('div', class_='rocom_sprite_grament_attributes')
                if attr_container:
                    p_tags = attr_container.find_all('p')
                    for p in p_tags:
                        cn_type = p.get_text(strip=True)
                        # 如果在映射表里就用英文，不在就保留原样
                        en_type = self.type_map.get(cn_type, cn_type)
                        pet['types'].append(en_type)

                # 特性抓取与关联逻辑
                pet['trait'] = {}
                pet['evolutions'] = [pet['id']]

                char_box = soup.find('div', class_='rocom_sprite_temp_characteristic_box')
                if char_box:
                    t_name = char_box.find('p', class_='rocom_sprite_info_characteristic_title').get_text(strip=True)
                    t_desc = char_box.find('p', class_='rocom_sprite_info_characteristic_text').get_text(strip=True)
                    t_img = char_box.find('img')

                    img_url = ""
                    if t_img and t_img.get('src'):
                        img_url = t_img.get('src')
                        if img_url.startswith('//'): img_url = 'https:' + img_url

                    if img_url:
                        if img_url in self.ability_registry:
                            reg = self.ability_registry[img_url]
                            if pet['id'] not in reg['evolutions']:
                                reg['evolutions'].append(pet['id'])

                            pet['trait'] = {
                                "id": f"A{reg['first_id']}",
                                "name": t_name,
                                "description": t_desc,
                                "image": f"ability_{reg['first_id']}.png"
                            }
                            pet['evolutions'] = reg['evolutions']
                        else:
                            image_file = self._download_ability_image(img_url, pet['id'])
                            self.ability_registry[img_url] = {
                                "first_id": pet['id'],
                                "evolutions": [pet['id']]
                            }
                            pet['trait'] = {
                                "id": f"A{pet['id']}",
                                "name": t_name,
                                "description": t_desc,
                                "image": image_file
                            }
                            pet['evolutions'] = self.ability_registry[img_url]['evolutions']

                # 其他信息解析
                info_box = soup.find('div', class_='rocom_sprite_info')
                if info_box:
                    title_div = info_box.find('div', class_='rocom_sprite_info_title')
                    if title_div and len(title_div.find_all('p')) > 1:
                        pet['total_stats'] = title_div.find_all('p')[1].get_text(strip=True)

                    stats = {}
                    for li in info_box.select('.rocom_sprite_info_qualification li'):
                        n = li.find('p', class_='rocom_sprite_info_qualification_name')
                        v = li.find('p', class_='rocom_sprite_info_qualification_value')
                        if n and v: stats[n.get_text(strip=True)] = v.get_text(strip=True)
                    pet['stats'] = stats

                    phys = info_box.select('.rocom_sprite_info_physique li')
                    if len(phys) >= 2:
                        p0, p1 = phys[0].find_all('p'), phys[1].find_all('p')
                        if len(p0) >= 3: pet['height'] = f"{p0[1].get_text(strip=True)}{p0[2].get_text(strip=True)}"
                        if len(p1) >= 3: pet['weight'] = f"{p1[1].get_text(strip=True)}{p1[2].get_text(strip=True)}"

                desc_box = soup.find('div', class_='rocom_sprite_info_content')
                pet['description'] = desc_box.get_text(strip=True) if desc_box else ""

                print(f"完成: {pet['id']} {pet['name']} {pet['types']}")
                return pet

            except Exception as e:
                print(f"解析 {pet['name']} 失败: {e}")
                time.sleep(5)
        return pet

    def _sync_all_evolutions(self, results):
        trait_id_to_evos = {}
        for p in results:
            if p.get('trait') and p['trait'].get('id'):
                trait_id_to_evos[p['trait']['id']] = p['evolutions']

        for p in results:
            if p.get('trait') and p['trait'].get('id'):
                tid = p['trait']['id']
                if tid in trait_id_to_evos:
                    p['evolutions'] = trait_id_to_evos[tid]

    def run(self):
        with open(self.input_file, 'r', encoding='utf-8') as f:
            all_pets = json.load(f)

        results = []
        for pet in all_pets:
            updated_pet = self.parse_detail_page(pet)
            results.append(updated_pet)

            self._sync_all_evolutions(results)
            with open(self.output_file, 'w', encoding='utf-8') as f:
                json.dump(results, f, ensure_ascii=False, indent=4)

            wait = random.uniform(1, 2)
            time.sleep(wait)


if __name__ == "__main__":
    rescuer = RocomRescuer()
    rescuer.run()