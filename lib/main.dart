import 'package:flutter/material.dart';
import 'models/pet.dart';
import 'tabs/pokedex_tab.dart';
import 'tabs/settings_tab.dart';

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
  int _currentTab = 0;
  int _selectedIndex = 0;

  bool _isColorLocked = false; 
  PetType _selectedType = PetType.light; 

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

  @override
  Widget build(BuildContext context) {
    // 如果锁定则使用自选色，否则跟随宠物 
    final Color currentTheme = _isColorLocked 
        ? _selectedType.themeColor 
        : _pokedex[_selectedIndex].type.themeColor;

    return Scaffold(
      // 使用 AnimatedContainer 让色系切换时有平滑过渡效果
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: currentTheme,
        child: Row(
          children: [
            _buildNavigationRail(), 
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), 
                  borderRadius: BorderRadius.circular(40), 
                  border: Border.all(color: Colors.white.withOpacity(0.3))
                ),
                child: _buildMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildMainContent() {
  // 核心逻辑：计算当前真正的强调色
  // 如果锁定了色系，强调色应使用手动选中的色系；否则跟随当前宠物系别
  final Color currentEffectiveColor = _isColorLocked 
      ? _selectedType.themeColor 
      : _pokedex[_selectedIndex].type.themeColor;

  if (_currentTab == 2) {
    return SettingsTab(
      accentColor: currentEffectiveColor, // 这里传递计算后的最终颜色
      isColorLocked: _isColorLocked,
      selectedType: _selectedType,
      onLockChanged: (v) => setState(() => _isColorLocked = v),
      onTypeChanged: (t) => setState(() => _selectedType = t),
    );
  }
  
  // 宠物图鉴页也建议同步使用这个 currentEffectiveColor 以保持视觉统一
  return PokedexTab(
    pokedex: _pokedex,
    selectedIndex: _selectedIndex,
    onSelected: (index) => setState(() => _selectedIndex = index),
  );
}

  Widget _buildNavigationRail() {
    return Container(
      width: 88, padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          const Icon(Icons.catching_pokemon, color: Colors.white, size: 32),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), 
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(40), border: Border.all(color: Colors.white.withOpacity(0.1))), 
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                _buildNavBtn(0, Icons.auto_awesome_motion_rounded), 
                const SizedBox(height: 20), 
                _buildNavBtn(1, Icons.compare_arrows_rounded), 
                const SizedBox(height: 20), 
                _buildNavBtn(2, Icons.settings_rounded)
              ]
            )
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNavBtn(int index, IconData icon) {
    final bool isSelected = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400), 
        curve: Curves.easeOutBack, 
        width: 50, height: 50, 
        decoration: BoxDecoration(color: isSelected ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(25)), 
        child: Icon(icon, size: 26, color: isSelected ? Colors.black87 : Colors.white.withOpacity(0.5))
      ),
    );
  }
}