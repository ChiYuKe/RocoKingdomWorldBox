import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../widgets/radar_chart.dart';

class PokedexTab extends StatelessWidget {
  final List<Pet> pokedex;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Color accentColor; 
  
  

  const PokedexTab({
    super.key,
    required this.pokedex,
    required this.selectedIndex,
    required this.onSelected,
    required this.accentColor,

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
            accentColor: accentColor,
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

  // 记录当前选中的属性集合
  final Set<PetType> _selectedTypes = {};


  @override
  void dispose() { _scrollController.dispose(); super.dispose(); }

  // 通用的弹出窗口方法
  void _showOverlay(BuildContext context, String title, Widget content) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: title,
      barrierColor: Colors.black54, // 背景遮罩颜色
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: Curves.easeOutCubic.transform(anim1.value), // 缩放动画
          child: Opacity(
            opacity: anim1.value,
            child: AlertDialog(
              backgroundColor: const Color(0xFF1A1A1A), // 深灰色背景
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
              content: SizedBox(
                width: 300,
                child: content,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("确定", style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 40, bottom: 10, right: 16), // 增加了右内边距
            child: Row( // 使用 Row 包裹标题和按钮
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "精灵图鉴",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                // --- 新增的按钮组 ---
                Row(
                  children: [
                    _buildHeaderButton(Icons.search, () {
                      _showOverlay(
                        context, 
                        "搜索精灵", 
                        TextField(
                          autofocus: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "输入名称或编号...",
                            hintStyle: const TextStyle(color: Colors.white24),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                            prefixIcon: const Icon(Icons.search, color: Colors.white38),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(width: 8),

                    _buildHeaderButton(Icons.tune_rounded, () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Filter",
                        barrierColor: Colors.black54,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (context, anim1, anim2) => StatefulBuilder( // 使用 StatefulBuilder 处理多选状态刷新
                          builder: (context, setModalState) {
                            return AlertDialog(
                              backgroundColor: const Color(0xFF1A1A1A),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              title: const Text("属性筛选", style: TextStyle(color: Colors.white, fontSize: 18)),
                              content: SizedBox(
                                width: 300,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 2.0,
                                  ),
                                  itemCount: PetType.values.length,
                                  itemBuilder: (context, index) {
                                    final type = PetType.values[index];
                                    final isSelected = _selectedTypes.contains(type); // 判断是否选中

                                    return GestureDetector(
                                      onTap: () {
                                        setModalState(() { // 刷新弹窗内部状态
                                          if (isSelected) {
                                            _selectedTypes.remove(type);
                                          } else {
                                            _selectedTypes.add(type);
                                          }
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          // --- 核心逻辑：选中显示实色，未选中显示灰色 ---
                                          color: isSelected ? type.themeColor : Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: isSelected ? [
                                            BoxShadow(
                                              color: type.themeColor.withOpacity(0),// 控制发光颜色阴影
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            )
                                          ] : [],
                                          border: Border.all(
                                            color: isSelected ? Colors.white24 : Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          type.label,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.white38, // 文本颜色同步切换
                                            fontSize: 12,
                                            fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // 清空选择
                                    setModalState(() => _selectedTypes.clear());
                                  },
                                  child: const Text("重置", style: TextStyle(color: Colors.white38)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      // 这里触发外部列表的过滤逻辑
                                    });
                                  },
                                  child: const Text("确定", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
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


  // 构建顶部功能按钮的小部件
  Widget _buildHeaderButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1), // 微弱的半透明背景
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white10, width: 1),
          ),
          child: Icon(
            icon,
            color: Colors.white70,
            size: 20,
          ),
        ),
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
  final Color accentColor; 

  const DetailPanel({
    super.key, 
    required this.pet, 
    required this.accentColor,
  });


  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF2D2D2D), 
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          bottomLeft: Radius.circular(80), 
          topRight: Radius.circular(35), 
          bottomRight: Radius.circular(35))),
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
                        Expanded( flex: 6,child: Wrap(runSpacing: 18, spacing: 20,
                          children: [
                            _buildAnimatedStat(label: "生命", value: pet.stats[0], color: accentColor),
                            _buildAnimatedStat(label: "物攻", value: pet.stats[1], color: accentColor),
                            _buildAnimatedStat(label: "魔攻", value: pet.stats[2], color: accentColor),
                            _buildAnimatedStat(label: "物防", value: pet.stats[3], color: accentColor),
                            _buildAnimatedStat(label: "魔防", value: pet.stats[4], color: accentColor),
                            _buildAnimatedStat(label: "速度", value: pet.stats[5], color: accentColor), 
                          ], ),
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
                _buildActionBtn(label: "技能详情", icon: Icons.bolt, color: accentColor,  onTap: () {}, ), 
                const SizedBox(width: 20), 
                _buildActionBtn( label: "进化链",  icon: Icons.history,  color: accentColor, onTap: () => _showEvolutionWindow(context),),
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




  /// 构建进化链的核心组件，根据传入的 ID 列表动态生成节点和连接线，支持分叉进化
  Widget _buildEvoTree(List<String> ids, String currentId, Function(String) onSelect) {
  // final themeColor = pet.type.themeColor;

  if (ids.length >= 4) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        _buildEvoNode(ids[0], currentId == ids[0], () => onSelect(ids[0])),
        _buildEvoLine(),
        _buildEvoNode(ids[1], currentId == ids[1], () => onSelect(ids[1])),
        
        // 分叉连接线，使用 CustomPaint 绘制两条平行的贝塞尔曲线形成分叉效果
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Transform.translate(
            // 这里向上偏移一个小数值,应该是底部文字和间距高度的一半
            offset: const Offset(0, -10), 
            child: CustomPaint(
              size: const Size(40, 110), 
              painter: EvoBranchPainter(color: Colors.white24),
            ),
          ),
        ),
        
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEvoNode(ids[2], currentId == ids[2], () => onSelect(ids[2])),
            const SizedBox(height: 30), 
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
 
  /// 构建单个进化节点，包含点击事件和选中状态的视觉反馈
  Widget _buildEvoNode(String id, bool isSelected, VoidCallback onTap) {
    final themeColor = pet.type.themeColor;
    
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 78, height: 78, 
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? themeColor.withOpacity(0.15) : Colors.black,
              border: Border.all(
                color: isSelected ? themeColor : Colors.white12, 
                width: isSelected ? 2.5 : 1.5
              ),
              boxShadow: isSelected ? [
                BoxShadow(color: themeColor.withOpacity(0.3), blurRadius: 12, spreadRadius: 2)
              ] : [],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/avatars/pet_$id.png',
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Icon(Icons.pets, color: Colors.white10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "No.$id", 
          style: TextStyle(
            // 未选中时使用 white54 确保在暗色背景下也能看清
            color: isSelected ? Colors.white : Colors.white54, 
            fontSize: 15, 
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          )
        ),
      ],
    );
  }

  /// 构建进化链连接线，使用简单的 Container 进行水平连接，并通过 Transform.translate 调整位置使其与节点更紧密连接
  Widget _buildEvoLine() {
    const double lineWidth = 5;// 线条宽度
    return Transform.translate(
      offset: const Offset(0, -10),// 向上偏移，使线条与节点更紧密连接
      child: Container(
        width: 30, 
        height: lineWidth,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(lineWidth / 3),
        ),
      ),
    );
  }

  /// 构建雷达图角落的属性图标，包含入场动画和回弹效果
  List<Widget> _buildCornerIcons(double width, double height) {
    final List<String> iconNames = ['ui_hp', 'ui_atk', 'ui_matk', 'ui_def', 'ui_mdef', 'ui_speed'];
    const double iconSize = 24.0;
    const double offsetPadding = 24.0; // 稍微增加一点偏移，给回弹留出视觉空间
    
    final center = Offset(width / 2, height / 2);
    final radius = math.min(width, height) / 2 * 0.8; // 图标距离中心的半径

    return List.generate(iconNames.length, (index) {
      final angle = index * (2 * math.pi / iconNames.length) - math.pi / 2;
      final double posX = center.dx + (radius + offsetPadding) * math.cos(angle) - (iconSize / 2);
      final double posY = center.dy + (radius + offsetPadding) * math.sin(angle) - (iconSize / 2);

      return Positioned(
        left: posX,
        top: posY,
        child: TweenAnimationBuilder<double>(
          key: ValueKey(iconNames[index]),
          // 稍微拉长一点时间，让回弹过程更清晰
          duration: const Duration(milliseconds: 350), 
          // 使用更剧烈的回弹曲线，或者直接用 Curves.linear 配合自定义逻辑
          curve: Curves.easeOutBack, 
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            // 当 value 从 0 -> 1 变化时：
            // 映射一个新的 scaleValue
            // 初始值 (value=0) 为 0.5
            // 结束值 (value=1) 为 1.0
            // 4. 配合 Curves.easeOutBack，value 会在中间阶段超过 1.0（最高约 1.1）
            double scaleValue = 0.5 + (value *0.5); 
            
            return Opacity(
              // 透明度依然保持平滑进入
              opacity: value.clamp(0.0, 1.0),
              child: Transform.scale(
                scale: scaleValue, 
                child: child,
              ),
            );
          },
          child: Image.asset(
            'assets/ui/${iconNames[index]}.png',
            width: iconSize,
            height: iconSize,
            cacheWidth: (iconSize * 2).toInt(), 
            cacheHeight: (iconSize * 2).toInt(),
            filterQuality: FilterQuality.medium, // 缩放时保持平滑
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.help_outline,
              size: 16, 
              color: Colors.white10
            ),
          ),
        ),
      );
    });
  }

  /// 构建带动画的能力值显示组件，包含标签、数值和进度条
  Widget _buildAnimatedStat({
    required String label,
    required double value,
    required Color color,
    double maxValue = 350.0, 
  }) {
    // 预计算进度比例，增加安全性检查
    final double progress = (value / maxValue).clamp(0.0, 1.0);

    return SizedBox(
      width: 145,
      child: Column(
        mainAxisSize: MainAxisSize.min, // 使 Column 占用最小垂直空间
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部文字行
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const Spacer(), // 使用 Spacer 替代 MainAxisAlignment.spaceBetween，布局更稳固
              Text(
                value.toInt().toString(),
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFeatures: const [FontFeature.tabularFigures()], //等宽数字，防止动画时文字抖动
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // 动画进度条
          SizedBox(
            height: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: progress),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                // 使用 child 参数防止 LinearProgressIndicator 意外重建
                builder: (context, animValue, _) {
                  return LinearProgressIndicator(
                    value: animValue,
                    backgroundColor: Colors.white.withOpacity(0.05),
                    color: color,
                    minHeight: 6,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建底部操作按钮，支持禁用状态显示
  Widget _buildActionBtn({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return TextButton( // 使用 TextButton 显得更轻量
      onPressed: onTap,
      style: TextButton.styleFrom(
        // 只在文字和图标上使用颜色，背景保持极其清淡
        foregroundColor: color,
        backgroundColor: color.withOpacity(0.08), 
        minimumSize: const Size(120, 40),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // 稍微硬朗一点的圆角
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18), // 稍微缩小图标
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500, // 降低字重，更清爽
            ),
          ),
        ],
      ),
    );
  }


}


/// 进化分支连接线的自定义画笔，绘制两条平行的贝塞尔曲线形成分叉效果
class EvoBranchPainter extends CustomPainter {
  final Color color;
  EvoBranchPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          color.withOpacity(0.5), 
          color.withOpacity(0.5), 
          color.withOpacity(0.5),],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    double startY = size.height / 2;
    
    // 绘制上半部分曲线
    path.moveTo(0, startY);
    path.cubicTo(size.width * 0.5, startY, size.width * 0.5, 0, size.width, 0);
    
    // 绘制下半部分曲线
    path.moveTo(0, startY);
    path.cubicTo(size.width * 0.5, startY, size.width * 0.5, size.height, size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


/// 一个在指定点立即跳转的曲线，用于取消 AnimatedSwitcher 的插值感
class InstantOutCurve extends Curve {
  @override
  double transformInternal(double t) => 0.0; // 无论动画进行到哪，输出始终为0（消失）
}
