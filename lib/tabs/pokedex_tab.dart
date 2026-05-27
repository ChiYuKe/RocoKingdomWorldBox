import 'package:flutter/material.dart';
import '../models/pet_catalog.dart';
import '../models/pet_model.dart';
import '../widgets/detail_panel.dart';
import '../widgets/card/petcard.dart';

class PokedexTab extends StatefulWidget {
  final PetCatalog catalog;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Color accentColor;

  const PokedexTab({
    super.key,
    required this.catalog,
    required this.selectedIndex,
    required this.onSelected,
    required this.accentColor,
  });

  @override
  State<PokedexTab> createState() => _PokedexTabState();
}

class _PokedexTabState extends State<PokedexTab> {
  int _globalLockedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.catalog.isEmpty) {
      return const Center(
        child: Text(
          '暂无精灵数据',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }

    final selectedIndex = widget.catalog.normalizeIndex(widget.selectedIndex);
    final selectedPet = widget.catalog.petAt(selectedIndex)!;

    return Row(
      children: [
        PetListView(
          catalog: widget.catalog,
          selectedIndex: selectedIndex,
          onSelected: widget.onSelected,
        ),
        Expanded(
          child: DetailPanel(
            petModel: selectedPet,
            accentColor: widget.accentColor,
            lockedIndex: _globalLockedIndex,
            onLockedIndexChanged: (index) {
              setState(() {
                _globalLockedIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}

class PetListView extends StatefulWidget {
  final PetCatalog catalog;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const PetListView({
    super.key,
    required this.catalog,
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

  void _showGooeyMenu(
    BuildContext context,
    Offset globalPos,
    List<PetModel> species,
  ) {
    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => GooeyMenuOverlay(
        startPosition: globalPos,
        species: species,
        currentSelectedId: widget.catalog.pets[widget.selectedIndex].id,
        onClose: () => entry?.remove(),
        onSelected: (pet) {
          widget.onSelected(widget.catalog.indexOf(pet));
          entry?.remove();
        },
      ),
    );
    Overlay.of(context).insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    final groups = widget.catalog.groups;

    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              top: 40,
              bottom: 10,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Icon(Icons.search, color: Colors.white.withValues(alpha: 0.3)),
              ],
            ),
          ),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple, Colors.purple, Colors.transparent],
                  stops: [0.0, 0.90, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: 60,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  final displayPet = group.displayPet;
                  final isGroupSelected = group.containsPetId(
                    widget.catalog.pets[widget.selectedIndex].id,
                  );

                  return GestureDetector(
                    onTapDown: (details) {
                      if (group.variants.length > 1) {
                        _showGooeyMenu(
                          context,
                          details.globalPosition,
                          group.variants,
                        );
                      } else {
                        widget.onSelected(widget.catalog.indexOf(displayPet));
                      }
                    },
                    child: PetCard(
                      petModel: displayPet,
                      index: index,
                      isSelected: isGroupSelected,
                      stackCount: group.variants.length,
                      onSelected: (_) {},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GooeyMenuOverlay extends StatefulWidget {
  final Offset startPosition;
  final List<PetModel> species;
  final int currentSelectedId;
  final VoidCallback onClose;
  final Function(PetModel) onSelected;

  const GooeyMenuOverlay({
    super.key,
    required this.startPosition,
    required this.species,
    required this.currentSelectedId,
    required this.onClose,
    required this.onSelected,
  });

  @override
  State<GooeyMenuOverlay> createState() => _GooeyMenuOverlayState();
}

class _GooeyMenuOverlayState extends State<GooeyMenuOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const menuWidth = 220.0;
    final menuHeight = (widget.species.length * 60.0 + 40).clamp(100.0, 450.0);

    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: Container(color: Colors.black26),
        ),
        ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            1,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            30,
            -1200,
          ]),
          child: AnimatedBuilder(
            animation: _scaleAnim,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    left: widget.startPosition.dx - 20,
                    top: widget.startPosition.dy - 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left:
                        widget.startPosition.dx +
                        40 -
                        (menuWidth * 0.5 * _scaleAnim.value),
                    top:
                        widget.startPosition.dy -
                        (menuHeight * 0.5 * _scaleAnim.value),
                    child: Container(
                      width: menuWidth * _scaleAnim.value,
                      height: menuHeight * _scaleAnim.value,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        AnimatedBuilder(
          animation: _scaleAnim,
          builder: (context, child) {
            if (_scaleAnim.value < 0.7) return const SizedBox();
            return Positioned(
              left: widget.startPosition.dx + 40 - (menuWidth * 0.5),
              top: widget.startPosition.dy - (menuHeight * 0.5),
              child: Opacity(
                opacity: ((_scaleAnim.value - 0.7) * 3.3).clamp(0, 1),
                child: Container(
                  width: menuWidth,
                  height: menuHeight,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.species.length,
                    itemBuilder: (context, index) {
                      final pet = widget.species[index];
                      final isCurrent = pet.id == widget.currentSelectedId;
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => widget.onSelected(pet),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/Icon/BigHeadIcon256/${pet.id}.png',
                                  width: 36,
                                  height: 36,
                                  errorBuilder: (c, e, s) => const Icon(
                                    Icons.pets,
                                    size: 18,
                                    color: Colors.white24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    pet.name,
                                    style: TextStyle(
                                      color: isCurrent
                                          ? Colors.white
                                          : Colors.white70,
                                      fontSize: 13,
                                      fontWeight: isCurrent
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isCurrent)
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
