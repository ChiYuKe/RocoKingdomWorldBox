import 'package:flutter_test/flutter_test.dart';
import 'package:rocokingdomworldbox/models/json_reader.dart';
import 'package:rocokingdomworldbox/models/pet_catalog.dart';
import 'package:rocokingdomworldbox/models/pet_model.dart';
import 'package:rocokingdomworldbox/models/settingsprovider.dart';
import 'package:rocokingdomworldbox/models/skill_model.dart';
import 'package:rocokingdomworldbox/plugins/plugin_registry.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('SkillType falls back to physical for unknown ids', () {
    expect(SkillType.fromId(1), SkillType.physical);
    expect(SkillType.fromId(2), SkillType.magic);
    expect(SkillType.fromId(3), SkillType.change);
    expect(SkillType.fromId(-1), SkillType.physical);
  });

  test('SettingsProvider guards invalid persisted values', () async {
    SharedPreferences.setMockInitialValues({
      'selectedTypeIndex': 999,
      'colorIntensity': 2.5,
    });

    final settings = SettingsProvider();
    await settings.init();

    expect(settings.selectedType, PetType.cute);
    expect(settings.colorIntensity, 1.0);

    settings.setColorIntensity(-1);
    expect(settings.colorIntensity, 0.0);
  });

  test('PluginRegistry registers all built-in plugins', () {
    const registry = PluginRegistry();

    final plugins = registry.buildPlugins(const <PetModel>[]);

    expect(plugins.map((plugin) => plugin.name), contains('精灵对比'));
    expect(plugins.length, greaterThanOrEqualTo(4));
  });

  test('JsonReader tolerates mixed primitive shapes', () {
    final json = <String, dynamic>{
      'id': '3001',
      'scale': '1.25',
      'name': 3001,
      'ids': ['1', 2, 3.6, null],
      'points': ['1.5', 2, null],
    };

    expect(json.intValue('id'), 3001);
    expect(json.doubleValue('scale'), 1.25);
    expect(json.stringValue('name'), '3001');
    expect(json.intListValue('ids'), [1, 2, 3, 0]);
    expect(json.doubleListValue('points'), [1.5, 2.0, 0.0]);
    expect(json.intValue('missing'), 0);
  });

  test('VersionedJsonRecords validates the expected asset envelope', () {
    final records = VersionedJsonRecords.fromJson({
      'version': '2',
      'data': {
        'a': {'id': 1},
      },
    });

    expect(records.version, 2);
    expect(records.records.keys, contains('a'));
    expect(
      () => VersionedJsonRecords.fromJson({'version': 1}),
      throwsFormatException,
    );
  });

  test('PetCatalog sorts pets and groups variants by pictorial id', () {
    final firstVariant = PetModel()
      ..id = 3002
      ..pictorialBookId = 1;
    final secondVariant = PetModel()
      ..id = 3001
      ..pictorialBookId = 1;
    final otherPet = PetModel()
      ..id = 4001
      ..pictorialBookId = 2;

    final catalog = PetCatalog.fromPets([
      otherPet,
      firstVariant,
      secondVariant,
    ]);

    expect(catalog.pets.map((pet) => pet.id), [3001, 3002, 4001]);
    expect(catalog.groups.length, 2);
    expect(catalog.groups.first.variants.map((pet) => pet.id), [3001, 3002]);
    expect(catalog.normalizeIndex(99), 2);
    expect(catalog.indexOf(firstVariant), 1);
  });
}
