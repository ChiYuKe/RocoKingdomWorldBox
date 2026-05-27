import 'package:isar/isar.dart';

import 'json_reader.dart';

part 'pet_evolution.g.dart';

@collection
class PetEvolution {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int id;

  String? name;
  List<int>? allowShowTeamBattleStarArray;
  int? pvpMuteGroup;
  int? evolutionGroup;
  int? handbookEvolutionGroup;
  int? statisticsEvolutionGroup;
  List<EvolutionNode>? evolutionChain;
  int? talentRandomId;

  late int lastSyncedVersion;

  PetEvolution();

  factory PetEvolution.fromJson(Map<String, dynamic> json) {
    return PetEvolution()
      ..id = json.intValue('id')
      ..name = json.stringValue('name')
      ..allowShowTeamBattleStarArray = json.intListValue(
        'allow_show_team_battle_star_array',
      )
      ..pvpMuteGroup = json.intValue('pvp_mute_group')
      ..evolutionGroup = json.intValue('evolution_group')
      ..handbookEvolutionGroup = json.intValue('handbook_evolution_group')
      ..statisticsEvolutionGroup = json.intValue('statistics_evolution_group')
      ..talentRandomId = json.intValue('talent_random_id')
      ..evolutionChain = json
          .objectListValue('evolution_chain')
          .map(EvolutionNode.fromJson)
          .toList();
  }
}

@embedded
class EvolutionNode {
  int? petbaseId;
  String? petName;
  int? stage;
  int? level;
  List<int>? unitType;

  EvolutionNode();

  factory EvolutionNode.fromJson(Map<String, dynamic> json) {
    return EvolutionNode()
      ..petbaseId = json.intValue('petbase_id')
      ..petName = json.stringValue('pet_name')
      ..stage = json.intValue('stage')
      ..level = json.intValue('level')
      ..unitType = json.intListValue('unit_type');
  }
}
