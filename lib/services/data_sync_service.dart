import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:flutter/foundation.dart';
import '../models/json_reader.dart';
import '../models/skill_model.dart';
import '../models/pet_model.dart';
import '../models/sync_config.dart';
import '../models/pet_evolution.dart';

class DataSyncService {
  final Isar isar;

  DataSyncService(this.isar);

  Future<void> runAllSync() async {
    await _syncRecords<PetModel>(
      assetPath: 'assets/data/I_PETBASE_CONF.json',
      fileKey: 'pet_base_conf',
      label: '宠物',
      parser: PetModel.fromJson,
      saveAll: (records) async {
        await isar.writeTxn(() async {
          await isar.petModels.putAll(records);
        });
      },
    );

    await _syncRecords<SkillModel>(
      assetPath: 'assets/data/I_SKILL_CONF.json',
      fileKey: 'skill_conf',
      label: '技能',
      parser: SkillModel.fromJson,
      saveAll: (records) async {
        await isar.writeTxn(() async {
          await isar.skillModels.putAll(records);
        });
      },
    );

    await _syncRecords<PetEvolution>(
      assetPath: 'assets/data/I_PET_EVOLUTION_CONF.json',
      fileKey: 'pet_evolution_conf',
      label: '宠物进化配置',
      parser: PetEvolution.fromJson,
      saveAll: (records) async {
        await isar.writeTxn(() async {
          await isar.petEvolutions.putAll(records);
        });
      },
    );
  }

  Future<void> _syncRecords<T>({
    required String assetPath,
    required String fileKey,
    required String label,
    required T Function(Map<String, dynamic> json) parser,
    required Future<void> Function(List<T> records) saveAll,
  }) async {
    await _syncFileIfNeeded(
      assetPath: assetPath,
      fileKey: fileKey,
      onSync: (data, version) async {
        final records = _parseRecords(
          data: data,
          version: version,
          label: label,
          parser: parser,
        );

        if (records.isEmpty) {
          debugPrint('Service: $fileKey 没有可同步的数据');
          return;
        }

        await saveAll(records);
        debugPrint('Service: $fileKey 同步成功：共 ${records.length} 条数据');
      },
    );
  }

  List<T> _parseRecords<T>({
    required dynamic data,
    required int version,
    required String label,
    required T Function(Map<String, dynamic> json) parser,
  }) {
    final dataMap = JsonReader.asObject(data);
    final records = <T>[];

    for (final entry in dataMap.entries) {
      try {
        final record = parser(JsonReader.asObject(entry.value));
        _setLastSyncedVersion(record, version);
        records.add(record);
      } catch (e) {
        debugPrint('错误：$label ID ${entry.key} 解析失败。具体原因: $e');
      }
    }

    return records;
  }

  void _setLastSyncedVersion<T>(T record, int version) {
    switch (record) {
      case PetModel model:
        model.lastSyncedVersion = version;
      case SkillModel model:
        model.lastSyncedVersion = version;
      case PetEvolution model:
        model.lastSyncedVersion = version;
    }
  }

  Future<void> _syncFileIfNeeded({
    required String assetPath,
    required String fileKey,
    required Future<void> Function(dynamic data, int version) onSync,
  }) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final recordsFile = VersionedJsonRecords.fromJson(
        json.decode(jsonString),
        source: assetPath,
      );
      final incomingVersion = recordsFile.version;

      final config = await isar.syncConfigs
          .where()
          .fileNameEqualTo(fileKey)
          .findFirst();
      final localVersion = config?.lastSyncedVersion ?? -1;

      if (incomingVersion != localVersion) {
        debugPrint(
          'Service: 正在更新 $fileKey ($localVersion -> $incomingVersion)',
        );
        await onSync(recordsFile.records, incomingVersion);

        await isar.writeTxn(() async {
          final newConfig = SyncConfig()
            ..fileName = fileKey
            ..lastSyncedVersion = incomingVersion;

          if (config != null) {
            newConfig.id = config.id;
          }
          await isar.syncConfigs.put(newConfig);
        });
      } else {
        debugPrint('Service: $fileKey 版本一致，跳过更新');
      }
    } catch (e) {
      debugPrint('Service: $fileKey 同步失败: $e');
    }
  }
}
