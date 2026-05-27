import 'package:isar/isar.dart';

import 'json_reader.dart';

part 'skill_model.g.dart';

/// 技能类型枚举
enum SkillType {
  physical(1, "物理"),
  magic(2, "魔法"),
  change(3, "变化");

  final int id;
  final String label;
  const SkillType(this.id, this.label);

  static SkillType fromId(int id) {
    return SkillType.values.firstWhere(
      (e) => e.id == id,
      orElse: () => SkillType.physical,
    );
  }
}

@collection
class SkillModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int id; // 技能 ID (如 200000)

  late int lastSyncedVersion;
  late String name;
  late String desc;

  late List<int> energyCost; // 消耗
  late List<int> damPara; // 伤害参数

  late int type; // 属性类型 (火、水等)
  late int skillDamType; // 1物理 2魔法 3变化
  late int skillFeature; // 技能特性
  late int damageType; // 伤害分类
  late int contactType; // 接触类型
  late int skillPriority; // 优先度
  late int targetType; // 目标类型
  late int targetCount; // 目标数量
  late List<int> cdRound; // CD回合
  late int hitPara; // 命中参数

  late String resId; // 资源路径
  late String icon; // 图标路径 (已通过脚本转换为 assets 路径)

  SkillModel();

  // 辅助获取技能伤害类型枚举
  @ignore
  SkillType get damTypeEnum => SkillType.fromId(skillDamType);

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel()
      ..id = json.intValue('id')
      ..name = json.stringValue('name')
      ..desc = json.stringValue('desc')
      ..energyCost = json.intListValue('energy_cost')
      ..damPara = json.intListValue('dam_para')
      ..type = json.intValue('type')
      ..skillDamType = json.intValue('skill_dam_type')
      ..skillFeature = json.intValue('skill_feature')
      ..damageType = json.intValue('damage_type')
      ..contactType = json.intValue('contact_type')
      ..skillPriority = json.intValue('skill_priority')
      ..targetType = json.intValue('target_type')
      ..targetCount = json.intValue('target_count')
      ..cdRound = json.intListValue('cd_round')
      ..hitPara = json.intValue('hit_para')
      ..resId = json.stringValue('res_id')
      ..icon = json.stringValue('icon');
  }
}
