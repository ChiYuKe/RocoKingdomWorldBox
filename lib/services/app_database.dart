import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/chat_message.dart';
import '../models/pet_evolution.dart';
import '../models/pet_model.dart';
import '../models/skill_model.dart';
import '../models/sync_config.dart';

class AppDatabase {
  const AppDatabase();

  Future<Isar> open() async {
    final dir = await getApplicationDocumentsDirectory();

    return Isar.getInstance() ??
        await Isar.open([
          SkillModelSchema,
          ChatMessageSchema,
          PetModelSchema,
          SyncConfigSchema,
          PetEvolutionSchema,
        ], directory: dir.path);
  }
}
