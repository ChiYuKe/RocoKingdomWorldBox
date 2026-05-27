import '../models/pet_model.dart';
import '../models/plugin_interface.dart';
import 'auto_script_plugin/main.dart' as auto_script;
import 'calc_plugin/main.dart' as calc;
import 'egg_group_plugin/main.dart' as egg_group;
import 'update_pet_data_plugin/main.dart' as update_pet_data;

class PluginRegistry {
  const PluginRegistry();

  List<RocoPlugin> buildPlugins(List<PetModel> pets) {
    return [
      calc.CalcPlugin(pictorialBookId: pets),
      update_pet_data.UpdatePetDataPlugin(),
      auto_script.AutoScriptPlugin(),
      egg_group.EggGroupPlugin(allPets: pets),
    ];
  }
}
