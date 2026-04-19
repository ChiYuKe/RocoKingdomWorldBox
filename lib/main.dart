import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'models/pet.dart';
import 'tabs/pokedex_tab.dart';
import 'tabs/settings_tab.dart';
import 'tabs/comparison_tab.dart';
import 'tabs/plugins_tab.dart';
import 'models/plugin_interface.dart';
import 'plugins/calc_plugin/main.dart' as calc;
import 'plugins/update_pet_data_plugin/main.dart' as update_pet_data;
import 'plugins/auto_script_plugin/main.dart' as auto_script;




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("环境变量加载失败: $e");
  }
  runApp(const RocoPokedexApp());
}



// void main() => runApp(const RocoPokedexApp());

class RocoPokedexApp extends StatelessWidget {
  const RocoPokedexApp({super.key});
  

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        fontFamily: 'MIANFEIZITI',
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // 数据库相关变量
  late Isar _isar;
  List<Pet> _pokedex = [];
  List<RocoPlugin> _plugins = [];
  bool _isLoading = true;

  // UI 状态变量
  int _currentTab = 0;
  int _selectedIndex = 0;
  bool _isColorLocked = false; 
  PetType _selectedType = PetType.light;
  double _colorIntensity = 0.8;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  /// 初始化数据库与数据
  Future<void> _initApp() async {

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([PetSchema], directory: dir.path);

    // 加载资源文件中的 JSON
    final String jsonString = await rootBundle.loadString('assets/data/pokedex.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final int jsonVersion = jsonMap['version'];

    // 检查本地版本号
    final prefs = await SharedPreferences.getInstance();
    final int localVersion = prefs.getInt('pokedex_version') ?? 0;

    // 如果 JSON 版本更高，则更新数据库  jsonVersion > localVersion
    if (true) {
      final List<dynamic> data = jsonMap['data'];
      final List<Pet> newPets = data.map((item) => Pet.fromJson(item)).toList();

      await _isar.writeTxn(() async {
        // 由于设置了 @Index(unique: true, replace: true)，相同 ID 的精灵会被自动覆盖
        await _isar.pets.putAll(newPets); 
      });

      // 更新本地版本记录
      await prefs.setInt('pokedex_version', jsonVersion);
    }

    // 从数据库读取最终展示数据
    final allPets = await _isar.pets.where().findAll();

    setState(() {
      _pokedex = allPets;
      _plugins = [
        calc.CalcPlugin(pokedex: _pokedex), 
        update_pet_data.UpdatePetDataPlugin(),
        auto_script.AutoScriptPlugin()
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 数据加载中显示加载动画，防止空数据索引崩溃
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    final Color currentEffectiveColor = _isColorLocked 
        ? _selectedType.themeColor 
        : _pokedex[_selectedIndex].types[0].themeColor;

    return Scaffold(
      backgroundColor: Color.lerp(
        const Color.fromARGB(255, 0, 0, 0), 
        currentEffectiveColor, 
        _colorIntensity
      ), 
      body: Row(
        children: [
          _buildNavigationRail(currentEffectiveColor), 
          Expanded(child: _buildMainContent(currentEffectiveColor)),
        ],
      ),
    );
  }

  Widget _buildNavigationRail(Color accentColor) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Color.lerp(const Color(0xFF252525), accentColor, _colorIntensity * 0.1),
      child: Column(
        children: [
          Icon(Icons.catching_pokemon, color: accentColor, size: 32),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), 
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2), 
              borderRadius: BorderRadius.circular(20), 
              border: Border.all(color: Colors.white.withOpacity(0.1))
            ), 
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                _buildNavBtn(0, Icons.auto_awesome_motion_rounded, "图鉴", accentColor), 
                const SizedBox(height: 16), 
                _buildNavBtn(1, Icons.compare_arrows_rounded, "克制", accentColor), 
                const SizedBox(height: 16), 
                _buildNavBtn(2, Icons.extension_rounded, "插件", accentColor), 
                const SizedBox(height: 16), 
                _buildNavBtn(3, Icons.settings_rounded, "设置", accentColor)
              ]
            )
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNavBtn(int index, IconData icon, String label, Color accentColor) {
    final bool isSelected = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400), 
        curve: Curves.easeOutBack, 
        width: 60, 
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? accentColor : Colors.transparent, 
          borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon, 
              color: isSelected ? Colors.white : Colors.white38, 
              size: 24
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white38,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(Color accentColor) {
    switch (_currentTab) {
      case 0:
        return PokedexTab(
          pokedex: _pokedex,
          selectedIndex: _selectedIndex,
          onSelected: (index) => setState(() => _selectedIndex = index),
          accentColor: accentColor,
        );
      case 1:
        return ComparisonTab(
          pokedex: _pokedex,
          accentColor: accentColor,
        );
      case 2:
        return PluginsTab(plugins: _plugins, accentColor: accentColor);
      case 3:
        return SettingsTab(
          accentColor: accentColor,
          isColorLocked: _isColorLocked,
          selectedType: _selectedType,
          colorIntensity: _colorIntensity,
          onLockChanged: (v) => setState(() => _isColorLocked = v),
          onTypeChanged: (t) => setState(() => _selectedType = t),
          onIntensityChanged: (v) => setState(() => _colorIntensity = v),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}