import json
import re


def transform_to_compact_json(input_file='pets_full.json', output_file='pokedex.json'):
    # 系别转换表
    type_map = {
        "火": "fire", "水": "water", "草": "grass", "光": "light",
        "普通": "ordinary", "龙": "dragon", "毒": "poison", "虫": "insect",
        "武": "valiant", "翼": "wing", "萌": "cute", "恶": "evil",
        "机械": "mechanical", "幻": "magical", "电": "electricity", "幽": "dark",
        "地": "mountain", "冰": "ice", "石": "stone"
    }

    # 读取原始数据
    with open(input_file, 'r', encoding='utf-8') as f:
        old_data = json.load(f)

    new_data = []
    for item in old_data:
        # 处理 Stats 字典转数字数组
        os = item.get('stats', {})
        stats_array = [
            int(os.get('生命', 0)), int(os.get('物攻', 0)), int(os.get('魔攻', 0)),
            int(os.get('物防', 0)), int(os.get('魔防', 0)), int(os.get('速度', 0))
        ]

        # 构造你要求的扁平化结构
        new_item = {
            "id": item.get('id'),
            "name": item.get('name'),
            "types": [type_map.get(t, t.lower()) for t in item.get('types', [])],
            "total_stats": str(item.get('total_stats', "0")),
            "stats": stats_array,
            "height": item.get('height', ""),
            "weight": item.get('weight', ""),
            "location": item.get('location', "未知"),
            "description": item.get('description', ""),
            "evolutions": item.get('evolutions', [item.get('id')]),
            "abilityId": item.get('trait', {}).get('id', f"A{item['id']}")
        }
        new_data.append(new_item)

    # 先生成带缩进的字符串
    json_str = json.dumps(new_data, ensure_ascii=False, indent=2)

    # 使用正则表达式把数组压缩回一行
    # 压缩 stats 这种数字数组 [ 120, 80, ... ] -> [120, 80, ...]
    json_str = re.sub(r'\[\s+([\d,\s]+?)\s+\]',
                      lambda m: '[' + re.sub(r'\s+', ' ', m.group(1)).strip() + ']',
                      json_str)

    # 压缩 types 和 evolutions 这种字符串数组 [ "light" ] -> ["light"]
    json_str = re.sub(r'\[\s+("[^"]*"(?:,\s*"[^"]*")*)\s+\]',
                      lambda m: '[' + re.compile(r'\s+').sub(' ', m.group(1)).strip() + ']',
                      json_str)

    # 保存最终文件
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(json_str)

    print(f"转换完成！格式已按照要求优化。")


def extract_traits(input_file='pets_full.json', output_file='abilities.json'):
    # 读取原始精灵数据
    with open(input_file, 'r', encoding='utf-8') as f:
        pets_data = json.load(f)

    traits_list = []
    seen_ids = set()  # 用于记录已经提取过的特性ID

    for pet in pets_data:
        # 获取特性字典
        trait = pet.get('trait')

        # 如果该精灵有特性，且该特性ID还没被记录过
        if trait and isinstance(trait, dict):
            trait_id = trait.get('id')

            if trait_id and trait_id not in seen_ids:
                # 构造特性库所需的结构
                trait_entry = {
                    "id": trait_id,
                    "name": trait.get('name', ''),
                    "description": trait.get('description', ''),
                    "image": trait.get('image', '')
                }
                traits_list.append(trait_entry)
                seen_ids.add(trait_id)

    # 对特性库按照 ID 排序（可选，方便查看）
    traits_list.sort(key=lambda x: x['id'])

    # 保存为新的 JSON 文件
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(traits_list, f, ensure_ascii=False, indent=4)

    print(f"提取完成！共提取出 {len(traits_list)} 个独立特性。")
    print(f"保存路径: {output_file}")



if __name__ == "__main__":
    # 负责对爬取的json数据二次装换成自己需要的格式
   transform_to_compact_json()
   extract_traits()