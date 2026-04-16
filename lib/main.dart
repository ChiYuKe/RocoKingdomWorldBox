import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const RocoPokedexApp());

// 1. 定义精灵属性类型及对应的颜色主题
enum PetType {
  fire(Color(0xFFBD4A20), "火系"),
  water(Color.fromARGB(255, 40, 158, 255), "水系"),
  grass(Color.fromARGB(255, 78, 188, 115), "草系"),
  light(Color.fromARGB(255, 79, 193, 255), "光系"),
  ordinary(Color.fromARGB(255, 97, 152, 177), "普通"),
  dragon(Color.fromARGB(255, 228, 43, 43), "龙系"),
  poison(Color.fromARGB(255, 163, 100, 207), "毒系"),
  insect(Color.fromARGB(255, 151, 179, 70), "虫系"),
  valiant(Color.fromARGB(255, 255, 129, 79), "武系"),
  wing(Color.fromARGB(255, 71, 209, 219), "翼系"),
  cute(Color.fromARGB(255, 255, 128, 147), "萌系"),
  evil(Color.fromARGB(255, 233, 64, 120), "恶系"),
  mechanical(Color.fromRGBO(62, 194, 161, 1), "机械系"),
  magical(Color.fromARGB(255, 189, 164, 250), "幻系"),
  electricity(Color.fromARGB(255, 240, 200, 80), "电系"),
  dark(Color.fromARGB(255, 157, 86, 207), "幽系");

  final Color themeColor;
  final String label;
  const PetType(this.themeColor, this.label);
}

// 2. 精灵数据模型
class Pet {
  final String name;
  final String id;
  final PetType type;
  final List<double> stats;

  Pet({required this.name, required this.id, required this.type, required this.stats});
}

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
  int _currentTab = 0;
  int _selectedIndex = 0;

  final List<Pet> _pokedex = [
    Pet(name: "迪莫", id: "001", type: PetType.light, stats: [120, 80, 80, 105, 105, 92]),
    Pet(name: "喵喵", id: "002", type: PetType.grass, stats: [65, 66, 66, 49, 91, 33]),
    Pet(name: "喵呜", id: "003", type: PetType.grass, stats: [86, 87, 87, 65, 121, 44]),
    Pet(name: "魔力猫", id: "004", type: PetType.grass, stats: [108, 109, 109, 81, 151, 55]),
    Pet(name: "火花", id: "005", type: PetType.fire, stats: [70, 84, 37, 56, 43, 78]),
    Pet(name: "焰火", id: "006", type: PetType.fire, stats: [93, 111, 49, 75, 58, 104]),
    Pet(name: "火神", id: "007", type: PetType.fire, stats: [117, 139, 61, 94, 72, 130]),
    Pet(name: "水蓝蓝", id: "008", type: PetType.water, stats: [75, 35, 76, 56, 79, 51]),
    Pet(name: "波波拉", id: "009", type: PetType.water, stats: [100, 46, 102, 75, 106, 68]),
  ];

  @override
  Widget build(BuildContext context) {
    final Color currentTheme = _pokedex[_selectedIndex].type.themeColor;

    return Scaffold(
      backgroundColor: currentTheme,
      body: Row(
        children: [
          _buildNavigationRail(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: _buildBody(), // 根据索引动态切换内容
            ),
          ),
        ],
      ),
    );
  }

  // 根据当前选中的 Tab 返回不同的界面
  Widget _buildBody() {
    switch (_currentTab) {
      case 0:
        return Row(
          children: [
            PetListView(
              pokedex: _pokedex,
              selectedIndex: _selectedIndex,
              onSelected: (index) => setState(() => _selectedIndex = index),
            ),
            Expanded(
              child: DetailPanel(
                key: ValueKey(_selectedIndex),
                pet: _pokedex[_selectedIndex],
              ),
            ),
          ],
        );
      case 1:
        return const Center(
          child: Text("属性克制表 - 敬请期待", style: TextStyle(color: Colors.white, fontSize: 20)),
        );
      case 2:
        return const Center(
          child: Text("系统设置 - 敬请期待", style: TextStyle(color: Colors.white, fontSize: 20)),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildNavigationRail() {
    return Container(
      width: 88,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          const Icon(Icons.catching_pokemon, color: Colors.white, size: 32),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNavBtn(0, Icons.auto_awesome_motion_rounded),
                const SizedBox(height: 20),
                _buildNavBtn(1, Icons.compare_arrows_rounded),
                const SizedBox(height: 20),
                _buildNavBtn(2, Icons.settings_rounded),
              ],
            ),
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
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected ? Colors.black87 : Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}

// --- 以下内容完全还原为你原始代码的逻辑和样式 ---

class PetListView extends StatefulWidget {
  final List<Pet> pokedex;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const PetListView({
    super.key,
    required this.pokedex,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  State<PetListView> createState() => _PetListViewState();
}

class _PetListViewState extends State<PetListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 40, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "洛克图鉴",
                  style: TextStyle(
                    fontSize: 26, 
                    fontWeight: FontWeight.w900, 
                    color: Colors.white, 
                    letterSpacing: 2
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24, 
                    borderRadius: BorderRadius.circular(2)
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                  stops: [0.0, 0.00, 0.95, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: widget.pokedex.length,
                  itemBuilder: (context, index) {
                    final pet = widget.pokedex[index];
                    final isSelected = widget.selectedIndex == index;
                    return _buildPetCard(pet, index, isSelected);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(Pet pet, int index, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => widget.onSelected(index),
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? Colors.black.withOpacity(0.8) 
                    : const Color.fromARGB(1, 83, 81, 81).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: pet.type.themeColor.withOpacity(0.2), 
                    blurRadius: 15, 
                    spreadRadius: 1
                  )
                ] : [],
              ),
              child: Row(
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          isSelected ? pet.type.themeColor.withOpacity(0.4) : Colors.white10,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/avatars/pet_${pet.id}.png',
                        fit: BoxFit.contain,
                        cacheWidth: 120,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.pets,
                          color: isSelected ? Colors.white : Colors.white24,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: pet.type.themeColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            pet.type.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12, right: 16,
              child: Text(
                "#${pet.id}",
                style: TextStyle(
                  color: isSelected ? pet.type.themeColor.withOpacity(0.8) : const Color.fromARGB(228, 255, 255, 255),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPanel extends StatelessWidget {
  final Pet pet;
  const DetailPanel({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = pet.type.themeColor;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80), bottomLeft: Radius.circular(80),
          topRight: Radius.circular(35), bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            flex: 3,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.scale(scale: 0.8 + (0.2 * value), child: child),
              ),
              child: Image.asset(
                'assets/portraits/pet_${pet.id}.png',
                fit: BoxFit.contain,
                errorBuilder: (context, _, __) => Icon(Icons.catching_pokemon, size: 140, color: accentColor.withOpacity(0.1)),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        pet.name, 
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 32, 
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/ui/types/type_${pet.type.name}.png', 
                        width: 35, height: 35,
                        fit: BoxFit.contain,
                        errorBuilder: (context, _, __) => Container(
                          width: 30, height: 30,
                          decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                  Text("系列：${pet.type.label} | 编号：No.${pet.id}", style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Colors.white10, thickness: 1),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    StatRadarChart(stats: pet.stats, color: accentColor),
                                    ..._buildCornerIcons(constraints.maxWidth, constraints.maxHeight),
                                  ],
                                );
                              }
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          flex: 6,
                          child: Wrap(
                            runSpacing: 18,
                            spacing: 20,
                            children: [
                              _buildAnimatedStat("生命", pet.stats[0], accentColor),
                              _buildAnimatedStat("物攻", pet.stats[1], accentColor),
                              _buildAnimatedStat("魔攻", pet.stats[2], accentColor),
                              _buildAnimatedStat("物防", pet.stats[3], accentColor),
                              _buildAnimatedStat("魔防", pet.stats[4], accentColor),
                              _buildAnimatedStat("速度", pet.stats[5], accentColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionBtn("技能详情", Icons.bolt, accentColor),
                const SizedBox(width: 20),
                _buildActionBtn("进化链", Icons.history, accentColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCornerIcons(double width, double height) {
    final List<String> iconNames = ['ui_hp', 'ui_atk', 'ui_matk', 'ui_def', 'ui_mdef', 'ui_speed'];
    final center = Offset(width / 2, height / 2);
    final radius = math.min(width, height) / 2 * 0.85;
    final angleStep = 2 * math.pi / 6;
    const double iconSize = 24.0;

    return List.generate(6, (index) {
      final angle = index * angleStep - math.pi / 2;
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 800 + (index * 100)),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          final fixedRadius = radius + 22; 
          final x = center.dx + fixedRadius * math.cos(angle);
          final y = center.dy + fixedRadius * math.sin(angle);
          return Positioned(
            left: x - (iconSize / 2),
            top: y - (iconSize / 2),
            child: Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Transform.scale(scale: value, child: child),
            ),
          );
        },
        child: Image.asset(
          'assets/ui/${iconNames[index]}.png',
          width: iconSize, height: iconSize,
          errorBuilder: (c, e, s) => Container(
            width: iconSize, height: iconSize,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.bolt, size: 14, color: Colors.white24),
          ),
        ),
      );
    });
  }

  Widget _buildAnimatedStat(String label, double value, Color color) {
    return SizedBox(
      width: 145, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              Text("${value.toInt()}", style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: value / 350), 
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, animValue, _) => LinearProgressIndicator(
                value: animValue,
                backgroundColor: Colors.white.withOpacity(0.05),
                color: color,
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, IconData icon, Color color) {
    return FilledButton.tonal(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class StatRadarChart extends StatelessWidget {
  final List<double> stats;
  final Color color;
  const StatRadarChart({super.key, required this.stats, required this.color});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutQuart,
      builder: (context, animationValue, child) => CustomPaint(
          size: Size.infinite,
          painter: RadarChartPainter(stats, animationValue, color),
        ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<double> stats;
  final double animationValue;
  final Color color;
  RadarChartPainter(this.stats, this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.85;
    final angleStep = 2 * math.pi / 6;

    final webPaint = Paint()..color = Colors.white.withOpacity(0.08)..style = PaintingStyle.stroke;
    for (int i = 1; i <= 4; i++) {
      final r = radius * (i / 4);
      final path = Path();
      for (int j = 0; j < 6; j++) {
        final angle = j * angleStep - math.pi / 2;
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (j == 0) path.moveTo(x, y); else path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, webPaint);
    }

    final statPaint = Paint()..color = color.withOpacity(0.4)..style = PaintingStyle.fill;
    final statBorderPaint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2.0;

    final statPath = Path();
    for (int j = 0; j < stats.length; j++) {
      final angle = j * angleStep - math.pi / 2;
      // 映射到 350
      final currentRadius = radius * (stats[j] / 350) * animationValue; 
      final x = center.dx + currentRadius * math.cos(angle);
      final y = center.dy + currentRadius * math.sin(angle);
      if (j == 0) statPath.moveTo(x, y); else statPath.lineTo(x, y);
    }
    statPath.close();
    canvas.drawPath(statPath, statPaint);
    canvas.drawPath(statPath, statBorderPaint);
  }

  @override
  bool shouldRepaint(covariant RadarChartPainter old) => old.animationValue != animationValue || old.color != color;
}