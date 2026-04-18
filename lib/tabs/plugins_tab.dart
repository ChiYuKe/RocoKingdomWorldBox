import 'package:flutter/material.dart';
import '../models/plugin_interface.dart';

class PluginsTab extends StatelessWidget {
  final List<RocoPlugin> plugins;
  final Color accentColor;

  const PluginsTab({
    super.key,
    required this.plugins,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 30),
            Expanded(child: _buildPluginGrid(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("插件扩展", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            _buildBadge(),
          ],
        ),
        const SizedBox(height: 8),
        Text("通过插件扩展来增强图鉴功能", style: TextStyle(color: Colors.white.withOpacity(0.4))),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Text("${plugins.length}", style: TextStyle(color: accentColor, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPluginGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemCount: plugins.length + 1,
      itemBuilder: (context, index) {
        if (index < plugins.length) {
          return _buildPluginCard(context, plugins[index]);
        }
        // return _buildAddMoreCard();
      },
    );
  }

  Widget _buildPluginCard(BuildContext context, RocoPlugin plugin) {
    return GestureDetector(
      // 点击跳转逻辑 
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => plugin.buildEntryPage(context, accentColor),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF151515).withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: accentColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: plugin.buildIcon(context, accentColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plugin.name,
                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plugin.version,
                        style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plugin.description,
                    maxLines: 2, // 将行数增加到 2 行，通常能覆盖大部分描述
                    overflow: TextOverflow.ellipsis, // 确保超出部分显示 ... 而不是直接消失
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.35), 
                      fontSize: 11,
                      height: 1.2, // 适当调整行高，防止两行太挤
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "@${plugin.author}",
                    style: TextStyle(
                      color: accentColor.withOpacity(0.5), 
                      fontSize: 10,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMoreCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.5),
      ),
      child: Icon(Icons.add_circle_outline_rounded, color: Colors.white.withOpacity(0.15), size: 28),
    );
  }
}