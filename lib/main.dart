import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const RocoPokedexApp());

// 1. 定义精灵属性类型及对应的颜色主题
enum PetType {
  fire(Color.fromARGB(255, 182, 89, 77), "火系"),   
  water(Color.fromRGBO(109, 150, 201, 1), "水系"),  
  grass(Color.fromARGB(255, 130, 185, 115), "草系"),  
  light(Color.fromARGB(255, 192, 167, 108), "光系"),  
  dark(Color.fromARGB(255, 148, 114, 173), "暗系");   

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
          //设置全局默认字体
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
    Pet(name: "喵呜", id: "003", type: PetType.grass, stats: [80, 85, 75, 95, 70, 90]),
    Pet(name: "魔力猫", id: "004", type: PetType.grass, stats: [75, 90, 85, 80, 75, 75]),
    Pet(name: "火花", id: "005", type: PetType.fire, stats: [70, 75, 60, 90, 65, 95]),
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
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Row(
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      backgroundColor: Colors.transparent,
      selectedIndex: _currentTab,
      onDestinationSelected: (i) => setState(() => _currentTab = i),
      labelType: NavigationRailLabelType.all,
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.5)),
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.auto_awesome_motion), label: Text('图鉴', style: TextStyle(color: Colors.white))),
        NavigationRailDestination(icon: Icon(Icons.compare_arrows), label: Text('克制', style: TextStyle(color: Colors.white))),
        NavigationRailDestination(icon: Icon(Icons.settings_outlined), label: Text('设置', style: TextStyle(color: Colors.white))),
      ],
    );
  }
}

class PetListView extends StatelessWidget {
  final List<Pet> pokedex;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const PetListView({super.key, required this.pokedex, required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 20),
            child: Text("精灵图鉴", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pokedex.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;
                final pet = pokedex[index];
                
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    onTap: () => onSelected(index),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    tileColor: isSelected ? Colors.black87 : Colors.white.withOpacity(0.15),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected ? pet.type.themeColor.withOpacity(0.4) : Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/avatars/pet_${pet.id}.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.pets, color: Colors.white30, size: 20),
                        ),
                      ),
                    ),
                    title: Text(pet.name, style: const TextStyle(color: Colors.white, fontSize: 15)),
                    subtitle: Text("No.${pet.id}", style: TextStyle(color: isSelected ? Colors.white60 : Colors.white38, fontSize: 11)),
                  ),
                );
              },
            ),
          ),
        ],
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
              duration: const Duration(milliseconds: 100),
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
                  // 使用 Row 将名字和属性图片并排
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
                      const SizedBox(width: 5), // 名字和图标的间距
                      // 属性图标
                      Image.asset(
                        'assets/ui/types/type_${pet.type.name}.png', 
                        width: 35,
                        height: 35,
                        fit: BoxFit.contain,
                        // 如果图片不存在，显示一个圆点占位，颜色随属性变化
                        errorBuilder: (context, _, __) => Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: accentColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // -------------------------------------------

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

  // 计算并生成六个角的图标组件
  List<Widget> _buildCornerIcons(double width, double height) {
    final List<String> iconNames = ['ui_hp', 'ui_atk', 'ui_matk', 'ui_def', 'ui_mdef', 'ui_speed'];
    final center = Offset(width / 2, height / 2);
    final radius = math.min(width, height) / 2 * 0.85;
    final angleStep = 2 * math.pi / 6;
    const double iconSize = 24.0;

    return List.generate(6, (index) {
      final angle = index * angleStep - math.pi / 2;
      
      return TweenAnimationBuilder<double>(
        // 使用延时或者特定的 Curve 让动画更灵动
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 800 + (index * 100)), // 每个图标稍微错开一点时间
        curve: Curves.elasticOut, // 使用弹性曲线，产生原地弹跳感
        builder: (context, value, child) {
          // 固定在顶点位置，不再随 value 从中心点位移
          final fixedRadius = radius + 22; 
          final x = center.dx + fixedRadius * math.cos(angle);
          final y = center.dy + fixedRadius * math.sin(angle);
          
          return Positioned(
            left: x - (iconSize / 2),
            top: y - (iconSize / 2),
            // value 同时控制缩放和透明度，实现“原地长出来”的效果
            child: Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Transform.scale(
                scale: value, 
                child: child
              ),
            ),
          );
        },
        child: Image.asset(
          'assets/ui/${iconNames[index]}.png',
          width: iconSize,
          height: iconSize,
          errorBuilder: (c, e, s) => Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), 
              shape: BoxShape.circle
            ),
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
      // 这里的 350 是雷达图的最大数值映射参考
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