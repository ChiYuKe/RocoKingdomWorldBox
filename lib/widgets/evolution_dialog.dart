import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/pet_model.dart';
import '../models/pet_evolution.dart';

class EvolutionViewNode {
  final int id;
  final String name;
  final String portraitRes;
  final String iconRes;
  final int stage;
  final int level;
  final List<PetType> types;

  const EvolutionViewNode({
    required this.id,
    required this.name,
    required this.portraitRes,
    required this.iconRes,
    required this.stage,
    required this.level,
    required this.types,
  });
}

class EvolutionDialog extends StatefulWidget {
  final PetModel petModel;

  const EvolutionDialog({super.key, required this.petModel});

  @override
  State<EvolutionDialog> createState() => _EvolutionDialogState();
}

class _EvolutionDialogState extends State<EvolutionDialog> {
  List<EvolutionViewNode> _evolutionChain = [];
  EvolutionViewNode? _currentNode;

  bool _isHoveringShiny = false;
  bool _isLockedShiny = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  /// 多分支的进化数据初始化
  Future<void> _initData() async {
    try {
      final isar = Isar.getInstance();
      if (isar == null) return;

      final List<int> allChainPetIds = [];
      final Map<int, EvolutionNode> chainNodeByPetId = {};

      if (widget.petModel.petEvolutionId.isEmpty) {
        allChainPetIds.add(widget.petModel.id);
      } else {
        for (final evoId in widget.petModel.petEvolutionId) {
          final evoData = await isar.petEvolutions
              .filter()
              .idEqualTo(evoId)
              .findFirst();
          if (evoData?.evolutionChain != null) {
            for (final node in evoData!.evolutionChain!) {
              if (node.petbaseId != null &&
                  !allChainPetIds.contains(node.petbaseId)) {
                allChainPetIds.add(node.petbaseId!);
                chainNodeByPetId[node.petbaseId!] = node;
              }
            }
          }
        }
      }

      final List<EvolutionViewNode> nodes = [];
      for (final id in allChainPetIds) {
        final model = await isar.petModels.filter().idEqualTo(id).findFirst();
        final chainNode = chainNodeByPetId[id];
        if (model != null) {
          nodes.add(
            EvolutionViewNode(
              id: model.id,
              name: model.name,
              portraitRes: model.jlRes,
              iconRes: model.jlSmallRes,
              stage: chainNode?.stage ?? model.stage,
              level: chainNode?.level ?? 0,
              types: model.types,
            ),
          );
        }
      }

      if (mounted) {
        setState(() {
          _evolutionChain = nodes;
          _currentNode = nodes.firstWhere(
            (n) => n.id == widget.petModel.id,
            orElse: () => nodes.first,
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("加载多分支进化链失败: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// 路径逻辑封装
  String get _displayImagePath {
    if (_currentNode == null) return "";
    final path = _currentNode!.portraitRes;
    return (_isHoveringShiny || _isLockedShiny)
        ? path.replaceAll('.png', '_yise.png')
        : path;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    final themeColor = widget.petModel.types[0].themeColor;

    return Center(
      child: Container(
        width: 900,
        height: 520,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 50,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              _buildLeftPanel(themeColor),
              _buildRightPanel(themeColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftPanel(Color themeColor) {
    return Expanded(
      flex: 6,
      child: Container(
        color: const Color(0xFF151515),
        padding: const EdgeInsets.fromLTRB(40, 38, 32, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(themeColor),
            const Spacer(),
            _buildEvoTree(_evolutionChain, themeColor),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  /// 标题构建
  Widget _buildTitle(Color themeColor) {
    return Row(
      children: [
        Icon(Icons.hub_outlined, color: themeColor, size: 28),
        const SizedBox(width: 12),
        Text(
          "${_currentNode?.name ?? ""} 进化链",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildRightPanel(Color themeColor) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          border: Border(
            left: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: Stack(
          children: [
            _buildBackgroundId(),
            _buildPortrait(themeColor),
            Positioned(
              bottom: 30,
              right: 30,
              child: _buildShinyButton(themeColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundId() {
    return Positioned(
      bottom: -20,
      right: -10,
      child: Text(
        _currentNode?.id.toString() ?? "",
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.02),
          fontSize: 180,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildPortrait(Color themeColor) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: const InstantOutCurve(),
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(anim),
            child: child,
          ),
        ),
        child: Image.asset(
          _displayImagePath,
          key: ValueKey(_displayImagePath),
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => Icon(
            Icons.broken_image,
            size: 120,
            color: themeColor.withValues(alpha: 0.1),
          ),
        ),
      ),
    );
  }

  Widget _buildEvoTree(List<EvolutionViewNode> chain, Color themeColor) {
    if (chain.isEmpty) {
      return const Center(
        child: Text(
          "暂无进化链数据",
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      );
    }

    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final timeline = Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(chain.length, (index) {
              final node = chain[index];
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildEvoNode(node, themeColor),
                  if (index < chain.length - 1)
                    _buildEvoConnector(chain[index + 1], themeColor),
                ],
              );
            }),
          );

          final estimatedWidth = chain.length * 98 + (chain.length - 1) * 54;
          if (estimatedWidth <= constraints.maxWidth) {
            return Center(child: timeline);
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: timeline,
          );
        },
      ),
    );
  }

  Widget _buildEvoNode(EvolutionViewNode node, Color themeColor) {
    final bool isSelected = _currentNode?.id == node.id;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _currentNode = node),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          width: 98,
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 10),
          decoration: BoxDecoration(
            color: isSelected
                ? themeColor.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? themeColor.withValues(alpha: 0.95)
                  : Colors.white.withValues(alpha: 0.08),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: themeColor.withValues(alpha: 0.3),
                      blurRadius: 24,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF101010),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.8)
                            : Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        node.iconRes,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.pets, color: Colors.white24),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -7,
                    child: _buildStageBadge(node, themeColor, isSelected),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Text(
                node.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "No. ${node.id}",
                style: TextStyle(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.85)
                      : Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageBadge(
    EvolutionViewNode node,
    Color themeColor,
    bool isSelected,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isSelected ? themeColor : const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Text(
        "阶段 ${node.stage == 0 ? '-' : node.stage}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildEvoConnector(EvolutionViewNode next, Color themeColor) {
    final label = next.level > 0 ? "Lv.${next.level}" : "进化";

    return SizedBox(
      width: 54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: themeColor.withValues(alpha: 0.9),
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.09),
                        themeColor.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: themeColor.withValues(alpha: 0.95),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildShinyButton(Color themeColor) {
    final bool isActive = _isLockedShiny || _isHoveringShiny;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveringShiny = true),
      onExit: (_) => setState(() => _isHoveringShiny = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _isLockedShiny = !_isLockedShiny),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? themeColor.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: isActive ? themeColor : Colors.white24,
              width: 1.5,
            ),
          ),
          child: Image.asset(
            'assets/ui/ui_shiny.png',
            width: 40,
            height: 40,
            errorBuilder: (_, _, _) => Icon(
              Icons.auto_awesome,
              color: isActive ? themeColor : Colors.white54,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class EvoBranchPainter extends CustomPainter {
  final Color color;
  const EvoBranchPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.cubicTo(
      size.width * 0.5,
      size.height * 0.5,
      size.width * 0.5,
      0,
      size.width,
      0,
    );
    path.moveTo(0, size.height / 2);
    path.cubicTo(
      size.width * 0.5,
      size.height * 0.5,
      size.width * 0.5,
      size.height,
      size.width,
      size.height,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant EvoBranchPainter oldDelegate) =>
      oldDelegate.color != color;
}

class InstantOutCurve extends Curve {
  const InstantOutCurve();
  @override
  double transformInternal(double t) => 0.0;
}
