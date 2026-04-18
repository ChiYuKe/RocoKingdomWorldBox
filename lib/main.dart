import 'package:flutter/material.dart';
import 'models/pet.dart';
import 'tabs/pokedex_tab.dart';
import 'tabs/settings_tab.dart';
import 'tabs/comparison_tab.dart';
import 'tabs/plugins_tab.dart';
import 'models/plugin_interface.dart';


import 'plugins/calc_plugin/main.dart' as calc;// 导入插件实现文件



void main() => runApp(const RocoPokedexApp());

class RocoPokedexApp extends StatelessWidget {
  const RocoPokedexApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, fontFamily: 'MIANFEIZITI'),
        home: const MainScaffold(),
      );
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  List<RocoPlugin> _plugins = [];
  int _currentTab = 0;
  int _selectedIndex = 0;

  // 是否锁定颜色逻辑
  bool _isColorLocked = false; 
  PetType _selectedType = PetType.light;
  
  double _colorIntensity = 0.8;



  final List<Pet> _pokedex = [
    Pet(name: "迪莫", id: "001", type: PetType.light, stats: [120, 80, 80, 105, 105, 92], evolutions: []),
    Pet(name: "喵喵", id: "002", type: PetType.grass, stats: [65, 66, 66, 49, 91, 33], evolutions: ["002","003", "004"]),
    Pet(name: "喵呜", id: "003", type: PetType.grass, stats: [86, 87, 87, 65, 121, 44], evolutions: ["002","003", "004"]),
    Pet(name: "魔力猫", id: "004", type: PetType.grass, stats: [108, 109, 109, 81, 151, 55], evolutions: ["002","003", "004"]),
    Pet(name: "火花", id: "005", type: PetType.fire, stats: [70, 84, 37, 56, 43, 78], evolutions: ["005", "006", "007"]),
    Pet(name: "焰火", id: "006", type: PetType.fire, stats: [93, 111, 49, 75, 58, 104], evolutions: ["005", "006", "007"]),
    Pet(name: "火神", id: "007", type: PetType.fire, stats: [117, 139, 61, 94, 72, 130], evolutions: ["005", "006", "007"]),
    Pet(name: "水蓝蓝", id: "008", type: PetType.water, stats: [75, 35, 76, 56, 79, 51], evolutions: ["008", "009", "010","10"]),
    Pet(name: "波波拉", id: "009", type: PetType.water, stats: [100, 46, 102, 75, 106, 68], evolutions: ["008", "009", "010"]),
    Pet(name: "乖乖鹄", id: "088", type: PetType.water, stats: [75, 57, 52, 83, 58, 69], evolutions: ["088", "089", "090", "091"]),
    Pet(name: "奇丽草", id: "041", type: PetType.grass, stats: [67, 69, 69, 73, 57, 48], evolutions: ["041", "042", "043"]),
  ];

  // 2. 使用 initState 进行初始化
  @override
  void initState() {
    super.initState();
    // 在这里初始化插件，此时 _pokedex 已经可以使用
    _plugins = [
      calc.CalcPlugin(pokedex: _pokedex),
    ];
  }



  @override
  Widget build(BuildContext context) {
    final Color currentEffectiveColor = _isColorLocked 
        ? _selectedType.themeColor 
        : _pokedex[_selectedIndex].type.themeColor;

    return Scaffold(
      // 使用变量控制背景色的混合深度
      backgroundColor: Color.lerp(const Color.fromARGB(255, 0, 0, 0), currentEffectiveColor, _colorIntensity), 
      body: Row(
        children: [
          _buildNavigationRail(currentEffectiveColor), 
          Expanded(child: _buildMainContent(currentEffectiveColor)),
        ],
      ),
    );
  }

  // 侧边栏方法
  Widget _buildNavigationRail(Color accentColor) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Color.lerp(const Color(0xFF252525), accentColor, _colorIntensity * 0.1), // 黑色恩和精灵色系做个混合不然有点刺眼
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

  // 导航按钮构建方法，包含动画效果和选中状态的视觉反馈
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


  // 主内容区域切换逻辑
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
          // 新增对比页面
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