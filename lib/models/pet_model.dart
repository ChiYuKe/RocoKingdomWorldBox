import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'json_reader.dart';

part 'pet_model.g.dart';

enum PetType {
  ordinary(2, Color(0xFF6198B1), "普通"),
  grass(3, Color.fromARGB(255, 84, 202, 123), "草系"),
  fire(4, Color.fromARGB(255, 226, 113, 72), "火系"),
  water(5, Color.fromARGB(255, 106, 169, 254), "水系"),
  light(6, Color(0xFF4FC1FF), "光系"),
  mountain(8, Color(0xFFF8A73D), "地系"),
  ice(9, Color(0xFF4CCCFF), "冰系"),
  dragon(10, Color.fromARGB(255, 237, 73, 98), "龙系"),
  electricity(11, Color(0xFFF0C850), "电系"),
  poison(12, Color(0xFFA364CF), "毒系"),
  insect(13, Color(0xFF97B346), "虫系"),
  valiant(14, Color.fromARGB(255, 255, 150, 54), "武系"),
  wing(15, Color(0xFF47D1DB), "翼系"),
  cute(16, Color(0xFFFF8093), "萌系"),
  dark(17, Color(0xFF9D56CF), "幽系"),
  evil(18, Color.fromARGB(255, 207, 70, 122), "恶系"),
  mechanical(19, Color(0xFF3EC2A1), "机械系"),
  magical(20, Color(0xFFBDA4FA), "幻系");

  final int id;
  final Color themeColor;
  final String label;

  const PetType(this.id, this.themeColor, this.label);

  // 根据 ID 获取枚举的静态方法
  static PetType? fromId(int id) {
    try {
      return PetType.values.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}

@collection
class PetModel {
  Id isarId = Isar.autoIncrement; // Isar 内部自增主键

  @Index(unique: true, replace: true)
  late int id; // 原始数据中的 ID (如 3001)

  late int lastSyncedVersion; // 记录同步版本
  late String name;
  late int bossType;
  late String moveType;
  late int completeness;
  late List<int> petEvolutionId;
  late int quality;
  late int stengthStage;
  late int stage;
  late int petScroe;
  late int consumeRoleHp;
  late int maxEnergy;
  late List<int> unitType;
  late int showTag;
  late int aiGroupInfoId;
  late int petHabitatGroupRoleType;
  late List<int> ecologyFeature;
  late int levelSkillConfId;
  late int petFeature;
  late int petChaosFeature;
  late int petGlassFeature;
  late int petIdleSkill;
  late int petLackenergySkill;
  late int modelConf;
  late String description;
  late double petScale;
  late int pictorialBookId;
  late int petfreeSort;
  late int petBondId;
  late List<int> petReaction;
  late List<int> evolutionPetId;
  late int bosspetbaseId;
  late List<int> bosspetbaseIdArry;
  late int basePointLimit;
  late int proportionMale;
  late List<int> natureIds;
  late int hpMaxRace;
  late int phyAttackRace;
  late int speAttackRace;
  late int phyDefenceRace;
  late int speDefenceRace;
  late int speedRace;
  late int sumRace;
  late int hpMaxFirst;
  late int phyAttackFirst;
  late int speAttackFirst;
  late int phyDefenceFirst;
  late int speDefenceFirst;
  late int speedFirst;
  late int criticalDam;
  late int grassEnhance;
  late int basePointType;
  late int petUiCameraType;
  late double petpageUiPercentage;
  late List<double> petpageCapsuleOffset;
  late double handbookUiPercentage;
  late List<double> handbookCapsuleOffset;
  late double petUiPercentage;
  late double formationUiScale;
  late List<double> uiCameraOffset;
  late double modelHeight;
  late int showArea;
  late int npcId;
  late int worldNature;
  late int substituteCharacter;
  late int substituteRandomSkill;
  late int catchThresholdBonustime;
  late int catchThresholdBonus;
  late int weightLow;
  late int weightHigh;
  late int heightLow;
  late int heightHigh;
  late int petClassisId;
  late int breakAwardSort;
  late List<int> enjoyFieldType;
  late List<int> hateFieldType;
  late int petSettledBasicReward;
  late int growXIndividuality;
  late int individualityLowerLimit;
  late int individualityUpperLimit;
  late String jlRes;
  late String jlSmallRes;
  late double resUiPercentage;
  late List<double> resOffset;
  late List<double> shadowUiPercentage;
  late List<double> shadowOffset;
  late List<double> shadowAngle;
  late double shadowOpacity;
  late String handbookStandpaintBg;
  late String handbookUnknownBg;
  late String shareBg;
  late String shareUncommonCardFg;
  late String shareUncommonCardBg;
  late String habit1;
  late int petEgg;
  late List<int> eggGroup;
  late int axialDensity; // 修改为 int
  late int radialDensity; // 修改为 int
  late int teamBattleAi; // 修改为 int，修复生成的 .g.dart 冲突
  late double weightCompensation;
  late int talentNormalChance;
  late int talentGoodChance;
  late int talentAmazingChance;
  late int talentPerfectChance;
  late List<int> petTrackNpcId;
  late String petTrackFailDesc;
  late int homeNpcId;
  late int wishNumber;
  late double reportResUiPercentage;
  late List<double> reportResOffset;
  late double cardResUiPercentage;
  late List<double> cardResOffset;
  late int talentRandomId;
  late int audioConfigId;
  late int fallingResistance;
  late int customGlassEggPiece;

  PetModel();

  @enumerated
  List<PetType> get types =>
      unitType.map((id) => PetType.fromId(id)).whereType<PetType>().toList();

  @ignore
  Color get mainColor =>
      types.isNotEmpty ? types.first.themeColor : Colors.grey;

  @enumerated
  List<int> get stats => [
    hpMaxRace, // 生命
    phyAttackRace, // 物攻
    speAttackRace, // 魔攻
    phyDefenceRace, // 物防
    speDefenceRace, // 魔防
    speedRace, // 速度
  ];

  @ignore
  List<String> get evolutions => ["3001", "3002", "3003"];

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel()
      ..id = json.intValue('id')
      ..lastSyncedVersion = json.intValue('lastSyncedVersion')
      ..name = json.stringValue('name')
      ..bossType = json.intValue('boss_type')
      ..moveType = json.stringValue('move_type')
      ..completeness = json.intValue('completeness')
      ..petEvolutionId = json.intListValue('pet_evolution_id')
      ..quality = json.intValue('quality')
      ..stengthStage = json.intValue('stength_stage')
      ..stage = json.intValue('stage')
      ..petScroe = json.intValue('pet_scroe')
      ..consumeRoleHp = json.intValue('consume_role_hp')
      ..maxEnergy = json.intValue('max_energy')
      ..unitType = json.intListValue('unit_type')
      ..showTag = json.intValue('show_tag')
      ..aiGroupInfoId = json.intValue('ai_group_info_id')
      ..petHabitatGroupRoleType = json.intValue('pet_habitat_group_role_type')
      ..ecologyFeature = json.intListValue('ecology_feature')
      ..levelSkillConfId = json.intValue('level_skill_conf_id')
      ..petFeature = json.intValue('pet_feature')
      ..petChaosFeature = json.intValue('pet_chaos_feature')
      ..petGlassFeature = json.intValue('pet_glass_feature')
      ..petIdleSkill = json.intValue('pet_idle_skill')
      ..petLackenergySkill = json.intValue('pet_lackenergy_skill')
      ..modelConf = json.intValue('model_conf')
      ..description = json.stringValue('description')
      ..petScale = json.doubleValue('pet_scale')
      ..pictorialBookId = json.intValue('pictorial_book_id')
      ..petfreeSort = json.intValue('petfree_sort')
      ..petBondId = json.intValue('pet_bond_id')
      ..petReaction = json.intListValue('pet_reaction')
      ..evolutionPetId = json.intListValue('evolution_pet_id')
      ..bosspetbaseId = json.intValue('bosspetbase_id')
      ..bosspetbaseIdArry = json.intListValue('bosspetbase_id_arry')
      ..basePointLimit = json.intValue('base_point_limit')
      ..proportionMale = json.intValue('proportion_male')
      ..natureIds = json.intListValue('nature_ids')
      ..hpMaxRace = json.intValue('hp_max_race')
      ..phyAttackRace = json.intValue('phy_attack_race')
      ..speAttackRace = json.intValue('spe_attack_race')
      ..phyDefenceRace = json.intValue('phy_defence_race')
      ..speDefenceRace = json.intValue('spe_defence_race')
      ..speedRace = json.intValue('speed_race')
      ..sumRace = json.intValue('SUM_race')
      ..hpMaxFirst = json.intValue('hp_max_first')
      ..phyAttackFirst = json.intValue('phy_attack_first')
      ..speAttackFirst = json.intValue('spe_attack_first')
      ..phyDefenceFirst = json.intValue('phy_defence_first')
      ..speDefenceFirst = json.intValue('spe_defence_first')
      ..speedFirst = json.intValue('speed_first')
      ..criticalDam = json.intValue('critical_dam')
      ..grassEnhance = json.intValue('grass_enhance')
      ..basePointType = json.intValue('base_point_type')
      ..petUiCameraType = json.intValue('pet_ui_camera_type')
      ..petpageUiPercentage = json.doubleValue('petpage_ui_percentage')
      ..petpageCapsuleOffset = json.doubleListValue('petpage_capsule_offset')
      ..handbookUiPercentage = json.doubleValue('handbook_ui_percentage')
      ..handbookCapsuleOffset = json.doubleListValue('handbook_capsule_offset')
      ..petUiPercentage = json.doubleValue('pet_ui_percentage')
      ..formationUiScale = json.doubleValue('formation_ui_scale')
      ..uiCameraOffset = json.doubleListValue('ui_camera_offset')
      ..modelHeight = json.doubleValue('model_height')
      ..showArea = json.intValue('show_area')
      ..npcId = json.intValue('npc_id')
      ..worldNature = json.intValue('world_nature')
      ..substituteCharacter = json.intValue('substitute_character')
      ..substituteRandomSkill = json.intValue('substitute_random_skill')
      ..catchThresholdBonustime = json.intValue('Catch_Threshold_Bonustime')
      ..catchThresholdBonus = json.intValue('Catch_Threshold_Bonus')
      ..weightLow = json.intValue('weight_low')
      ..weightHigh = json.intValue('weight_high')
      ..heightLow = json.intValue('height_low')
      ..heightHigh = json.intValue('height_high')
      ..petClassisId = json.intValue('pet_classis_id')
      ..breakAwardSort = json.intValue('break_award_sort')
      ..enjoyFieldType = json.intListValue('enjoy_field_type')
      ..hateFieldType = json.intListValue('hate_field_type')
      ..petSettledBasicReward = json.intValue('pet_settled_basic_reward')
      ..growXIndividuality = json.intValue('grow_x_individuality')
      ..individualityLowerLimit = json.intValue('individuality_lower_limit')
      ..individualityUpperLimit = json.intValue('individuality_upper_limit')
      ..jlRes = json.stringValue('JL_res')
      ..jlSmallRes = json.stringValue('JL_small_res')
      ..resUiPercentage = json.doubleValue('res_ui_percentage')
      ..resOffset = json.doubleListValue('res_offset')
      ..shadowUiPercentage = json.doubleListValue('shadow_ui_percentage')
      ..shadowOffset = json.doubleListValue('shadow_offset')
      ..shadowAngle = json.doubleListValue('shadow_angle')
      ..shadowOpacity = json.doubleValue('shadow_opacity')
      ..handbookStandpaintBg = json.stringValue('handbook_standpaint_bg')
      ..handbookUnknownBg = json.stringValue('handbook_unknown_bg')
      ..shareBg = json.stringValue('share_bg')
      ..shareUncommonCardFg = json.stringValue('share_uncommon_card_fg')
      ..shareUncommonCardBg = json.stringValue('share_uncommon_card_bg')
      ..habit1 = json.stringValue('habit_1')
      ..petEgg = json.intValue('pet_egg')
      ..eggGroup = json.intListValue('egg_group')
      ..axialDensity = json.intValue('axial_density')
      ..radialDensity = json.intValue('radial_density')
      ..teamBattleAi = json.intValue('team_battle_ai')
      ..weightCompensation = json.doubleValue('weight_compensation')
      ..talentNormalChance = json.intValue('talent_normal_chance')
      ..talentGoodChance = json.intValue('talent_good_chance')
      ..talentAmazingChance = json.intValue('talent_amazing_chance')
      ..talentPerfectChance = json.intValue('talent_perfect_chance')
      ..petTrackNpcId = json.intListValue('pet_track_npc_id')
      ..petTrackFailDesc = json.stringValue('pet_track_fail_desc')
      ..homeNpcId = json.intValue('home_npc_id')
      ..wishNumber = json.intValue('wish_number')
      ..reportResUiPercentage = json.doubleValue('report_res_ui_percentage')
      ..reportResOffset = json.doubleListValue('report_res_offset')
      ..cardResUiPercentage = json.doubleValue('card_res_ui_percentage')
      ..cardResOffset = json.doubleListValue('card_res_offset')
      ..talentRandomId = json.intValue('talent_random_id')
      ..audioConfigId = json.intValue('audio_config_id')
      ..fallingResistance = json.intValue('falling_resistance')
      ..customGlassEggPiece = json.intValue('custom_glass_egg_piece');
  }
}
