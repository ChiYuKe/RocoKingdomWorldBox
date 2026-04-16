import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/pet.dart';

class PokedexTab extends StatelessWidget {
  final List<Pet> pokedex;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const PokedexTab({
    super.key,
    required this.pokedex,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PetListView(
          pokedex: pokedex,
          selectedIndex: selectedIndex,
          onSelected: onSelected,
        ),
        Expanded(
          child: DetailPanel(
            key: ValueKey(selectedIndex),
            pet: pokedex[selectedIndex],
          ),
        ),
      ],
    );
  }
}

// 宠物列表组件 
class PetListView extends StatefulWidget {
  final List<Pet> pokedex;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const PetListView({super.key, required this.pokedex, required this.selectedIndex, required this.onSelected});

  @override
  State<PetListView> createState() => _PetListViewState();
}

class _PetListViewState extends State<PetListView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() { _scrollController.dispose(); super.dispose(); }

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
                const Text("洛克图鉴", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2)),
                Container(margin: const EdgeInsets.only(top: 4), width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect rect) => const LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                stops: [0.0, 0.00, 0.95, 1.0],
              ).createShader(rect),
              blendMode: BlendMode.dstIn,
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: widget.pokedex.length,
                  itemBuilder: (context, index) => _buildPetCard(widget.pokedex[index], index, widget.selectedIndex == index),
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
                color: isSelected ? Colors.black.withOpacity(0.8) : const Color.fromARGB(1, 83, 81, 81).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected ? [BoxShadow(color: pet.type.themeColor.withOpacity(0.2), blurRadius: 15, spreadRadius: 1)] : [],
              ),
              child: Row(
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [isSelected ? pet.type.themeColor.withOpacity(0.4) : Colors.white10, Colors.transparent])),
                    child: ClipOval(
                      child: Image.asset('assets/avatars/pet_${pet.id}.png', fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, color: Colors.white24, size: 28)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pet.name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: pet.type.themeColor.withOpacity(0.5), borderRadius: BorderRadius.circular(6)), child: Text(pet.type.label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(top: 12, right: 16, child: Text("#${pet.id}", style: TextStyle(color: isSelected ? pet.type.themeColor.withOpacity(0.8) : const Color.fromARGB(228, 255, 255, 255), fontSize: 11, fontWeight: FontWeight.w900))),
          ],
        ),
      ),
    );
  }
}

// 详情面板组件 
class DetailPanel extends StatelessWidget {
  final Pet pet;
  const DetailPanel({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = pet.type.themeColor;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color(0xFF2D2D2D), borderRadius: BorderRadius.only(topLeft: Radius.circular(80), bottomLeft: Radius.circular(80), topRight: Radius.circular(35), bottomRight: Radius.circular(35))),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(flex: 3, child: TweenAnimationBuilder<double>(tween: Tween(begin: 0.0, end: 1), duration: const Duration(milliseconds: 300), builder: (context, value, child) => Opacity(opacity: value, child: Transform.scale(scale: 0.8 + (0.2 * value), child: child)), child: Image.asset('assets/portraits/pet_${pet.id}.png', fit: BoxFit.contain, errorBuilder: (context, _, __) => Icon(Icons.catching_pokemon, size: 140, color: accentColor.withOpacity(0.1))))),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text(pet.name, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Image.asset('assets/ui/types/type_${pet.type.name}.png', width: 35, height: 35, fit: BoxFit.contain, errorBuilder: (context, _, __) => Container(width: 30, height: 30, decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle))),
                  ]),
                  Text("系列：${pet.type.label} | 编号：No.${pet.id}", style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: Colors.white10, thickness: 1)),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex: 4, child: AspectRatio(aspectRatio: 1, child: LayoutBuilder(builder: (context, constraints) => Stack(clipBehavior: Clip.none, children: [StatRadarChart(stats: pet.stats, color: accentColor), ..._buildCornerIcons(constraints.maxWidth, constraints.maxHeight)])))),
                        const SizedBox(width: 25),
                        Expanded(flex: 6, child: Wrap(runSpacing: 18, spacing: 20, children: [_buildAnimatedStat("生命", pet.stats[0], accentColor), _buildAnimatedStat("物攻", pet.stats[1], accentColor), _buildAnimatedStat("魔攻", pet.stats[2], accentColor), _buildAnimatedStat("物防", pet.stats[3], accentColor), _buildAnimatedStat("魔防", pet.stats[4], accentColor), _buildAnimatedStat("速度", pet.stats[5], accentColor)])),
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
                _buildActionBtn("技能详情", Icons.bolt, accentColor, () {}), 
                const SizedBox(width: 20), 
                _buildActionBtn("进化链", Icons.history, accentColor, () => _showEvolutionWindow(context))
              ]
            )
          ),
        ],
      ),
    );
  }




  
  // 进化链窗口
  void _showEvolutionWindow(BuildContext context) {
    String currentId = pet.id;
    
    // --- 状态变量定义在 StatefulBuilder 外部，通过闭包实现状态持久化 ---
    bool isHoveringShiny = false; // 鼠标悬停预览状态
    bool isLockedShiny = false;   // 点击锁定异色状态

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Evolution",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => Center(
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            // 计算最终是否显示异色：悬停或锁定任意一个为真即可
            final bool showShiny = isHoveringShiny || isLockedShiny;

            return Container(
              width: 900,
              height: 520,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 50,
                    spreadRadius: 10,
                  )
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    // 左边：进化分支链
                    Expanded(
                      flex: 6,
                      child: Container(
                        color: const Color(0xFF151515),
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.hub_outlined, color: pet.type.themeColor, size: 28),
                                const SizedBox(width: 12),
                                const Text("进化链",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2)),
                              ],
                            ),
                            const Spacer(),
                            Center(
                              child: _buildEvoTree(pet.evolutions, currentId, (newId) {
                                // 切换宠物时，建议重置异色状态，或者根据需要保留
                                setDialogState(() => currentId = newId);
                              }),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    // 右边：立绘展示
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF222222),
                          border: Border(left: BorderSide(color: Colors.white.withOpacity(0.05), width: 1)),
                        ),
                        child: Stack(
                          children: [
                            // 背景大数字 ID
                            Positioned(
                              bottom: -20,
                              right: -10,
                              child: Text(currentId,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.02),
                                      fontSize: 180,
                                      fontWeight: FontWeight.w900)),
                            ),


                            // 主立绘切换动画
                            Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                switchInCurve: Curves.easeOutBack,
                                switchOutCurve: InstantOutCurve(), 
                                
                               
                                layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                                  return currentChild ?? const SizedBox.shrink();
                                },
                                // ------------------------------------------------------------

                                transitionBuilder: (child, anim) {
                                  // 只有当前正在进入的 child (新ID) 才会显示并缩放
                                  return FadeTransition(
                                    opacity: anim,
                                    child: ScaleTransition(
                                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(anim),
                                      child: child,
                                    ),
                                  );
                                },
                                child: AnimatedSwitcher(
                                  key: ValueKey("evolution_group_$currentId"),
                                  duration: const Duration(milliseconds: 400),
                                  // 内层依然保持 Stack 布局以实现丝滑插值
                                  layoutBuilder: (currentChild, previousChildren) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [...previousChildren, if (currentChild != null) currentChild],
                                    );
                                  },
                                  transitionBuilder: (innerChild, innerAnim) => FadeTransition(opacity: innerAnim, child: innerChild),
                                  child: Image.asset(
                                    'assets/portraits/pet_$currentId${showShiny ? "_s" : ""}.png',
                                    key: ValueKey("portrait_${currentId}_$showShiny"),
                                    fit: BoxFit.contain,
                                    errorBuilder: (c, e, s) => Icon(Icons.broken_image, size: 120, color: pet.type.themeColor.withOpacity(0.1)),
                                  ),
                                ),
                              ),
                            ),


                            // 右下角异色切换 UI
                            Positioned(
                              bottom: 30,
                              right: 30,
                              child: MouseRegion(
                                onEnter: (_) => setDialogState(() => isHoveringShiny = true),
                                onExit: (_) => setDialogState(() => isHoveringShiny = false),
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => setDialogState(() => isLockedShiny = !isLockedShiny),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // --- 修改点 1：悬停或锁定都会让背景变亮 ---
                                      color: (isLockedShiny || isHoveringShiny)
                                          ? pet.type.themeColor.withOpacity(0.2) // 悬停时稍微亮一点
                                          : Colors.white.withOpacity(0.05),
                                      
                                      // --- 修改点 2：悬停或锁定都会改变边框颜色 ---
                                      border: Border.all(
                                        color: (isLockedShiny || isHoveringShiny) 
                                            ? pet.type.themeColor 
                                            : Colors.white24,
                                        width: 1.5,
                                      ),

                                      // --- 修改点 3：悬停或锁定都会产生外发光 ---
                                      boxShadow: (isLockedShiny || isHoveringShiny)
                                          ? [
                                              BoxShadow(
                                                color: pet.type.themeColor.withOpacity(0.3),
                                                blurRadius: 15, // 增加模糊半径，发光感更强
                                                spreadRadius: 2,
                                              )
                                            ]
                                          : [],
                                    ),
                                    child: Image.asset(
                                      'assets/ui/ui_shiny.png',
                                      width: 40,
                                      height: 40,
                                      // 这里的图标颜色也可以根据状态微调
                                      errorBuilder: (context, error, stackTrace) => Icon(
                                        (isLockedShiny || isHoveringShiny) 
                                            ? Icons.auto_awesome 
                                            : Icons.auto_awesome_outlined,
                                        color: (isLockedShiny || isHoveringShiny) 
                                            ? pet.type.themeColor 
                                            : Colors.white54,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEvoTree(List<String> ids, String currentId, Function(String) onSelect) {
    if (ids.length >= 4) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildEvoNode(ids[0], currentId == ids[0], () => onSelect(ids[0])),
          _buildEvoLine(),
          _buildEvoNode(ids[1], currentId == ids[1], () => onSelect(ids[1])),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("く", style: TextStyle(color: Colors.white10, fontSize: 60, fontWeight: FontWeight.w100))),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEvoNode(ids[2], currentId == ids[2], () => onSelect(ids[2])),
              const SizedBox(height: 50),
              _buildEvoNode(ids[3], currentId == ids[3], () => onSelect(ids[3])),
            ],
          )
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(ids.length, (i) => Row(children: [
        _buildEvoNode(ids[i], currentId == ids[i], () => onSelect(ids[i])),
        if (i < ids.length - 1) _buildEvoLine(),
      ])),
    );
  }

  Widget _buildEvoNode(String id, bool isSelected, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 85, height: 85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? pet.type.themeColor.withOpacity(0.3) : Colors.black,
              border: Border.all(color: isSelected ? pet.type.themeColor : Colors.white10, width: 3),
              boxShadow: isSelected ? [BoxShadow(color: pet.type.themeColor.withOpacity(0.4), blurRadius: 15)] : [],
            ),
            child: ClipOval(child: Image.asset('assets/avatars/pet_$id.png', errorBuilder: (c, e, s) => const Icon(Icons.pets, color: Colors.white10))),
          ),
        ),
        const SizedBox(height: 10),
        Text("No.$id", style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildEvoLine() => Container(width: 45, height: 2, color: Colors.white10, margin: const EdgeInsets.symmetric(horizontal: 5));

  //辅助函数：雷达图图标、进度条、按钮 
List<Widget> _buildCornerIcons(double width, double height) {
  final List<String> iconNames = ['ui_hp', 'ui_atk', 'ui_matk', 'ui_def', 'ui_mdef', 'ui_speed'];
  final center = Offset(width / 2, height / 2);
  final radius = math.min(width, height) / 2 * 0.85;
  const double iconSize = 24.0;

  return List.generate(6, (index) {
    final angle = index * (2 * math.pi / 6) - math.pi / 2;
    
    return Positioned(
      left: center.dx + (radius + 22) * math.cos(angle) - (iconSize / 2),
      top: center.dy + (radius + 22) * math.sin(angle) - (iconSize / 2),
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 400 ), 
        curve: Curves.easeOut, 
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            // 缩放动画，先放大后恢复到正常大小，增加弹性效果
            scale: value, 
            child: Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: child,
            ),
          );
        },
        child: Image.asset(
          'assets/ui/${iconNames[index]}.png',
          width: iconSize,
          height: iconSize,
          errorBuilder: (c, e, s) => const Icon(
            Icons.bolt, 
            size: 14, 
            color: Colors.white24
          ),
        ),
      ),
    );
  });
}

  Widget _buildAnimatedStat(String label, double value, Color color) {
    return SizedBox(width: 145, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)), Text("${value.toInt()}", style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold))]), const SizedBox(height: 8), ClipRRect(borderRadius: BorderRadius.circular(4), child: TweenAnimationBuilder<double>(tween: Tween(begin: 0.0, end: value / 350), duration: const Duration(milliseconds: 800), curve: Curves.easeOutCubic, builder: (context, animValue, _) => LinearProgressIndicator(value: animValue, backgroundColor: Colors.white.withOpacity(0.05), color: color, minHeight: 6)))]));
  }

  Widget _buildActionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return FilledButton.tonal(onPressed: onTap, style: FilledButton.styleFrom(backgroundColor: color.withOpacity(0.2), foregroundColor: color, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 18), const SizedBox(width: 8), Text(label)]));
  }
}

/// 一个在指定点立即跳转的曲线，用于取消 AnimatedSwitcher 的插值感
class InstantOutCurve extends Curve {
  @override
  double transformInternal(double t) => 0.0; // 无论动画进行到哪，输出始终为0（消失）
}

// 雷达图绘制类
class StatRadarChart extends StatelessWidget {
  final List<double> stats;
  final Color color;
  const StatRadarChart({super.key, required this.stats, required this.color});
  @override
  Widget build(BuildContext context) => 
  TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1),
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutQuart, 
    builder: (context, animationValue, child) => 
    CustomPaint(
      size: Size.infinite,
        painter: RadarChartPainter(stats, animationValue, color)
    )
  );
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
        if (j == 0) path.moveTo(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));
        else path.lineTo(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));
      }
      path.close(); canvas.drawPath(path, webPaint);
    }
    final statPaint = Paint()..color = color.withOpacity(0.4)..style = PaintingStyle.fill;
    final statBorderPaint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2.0;
    final statPath = Path();
    for (int j = 0; j < stats.length; j++) {
      final angle = j * angleStep - math.pi / 2;
      final currentRadius = radius * (stats[j] / 350) * animationValue;
      if (j == 0) statPath.moveTo(center.dx + currentRadius * math.cos(angle), center.dy + currentRadius * math.sin(angle));
      else statPath.lineTo(center.dx + currentRadius * math.cos(angle), center.dy + currentRadius * math.sin(angle));
    }
    statPath.close(); canvas.drawPath(statPath, statPaint); canvas.drawPath(statPath, statBorderPaint);
  }
  @override
  bool shouldRepaint(covariant RadarChartPainter old) => old.animationValue != animationValue || old.color != color;
}