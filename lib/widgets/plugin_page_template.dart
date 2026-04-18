import 'package:flutter/material.dart';

class PluginPageTemplate extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color accentColor;
  final Widget body;

  const PluginPageTemplate({
    super.key,
    required this.title,
    this.subTitle = "DATA ANALYSIS SYSTEM",
    required this.accentColor,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 背景保持深色，采用更具高级感的深灰
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            // 内容区域与导航栏通过一条极简的线分割
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withOpacity(0.05),
            ),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // 纯色背景，取消所有渐变效果
      color: const Color(0xFF1A1A1A),
      child: Row(
        children: [
          // 几何化的返回按钮
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // 标题区域
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // 强调装饰块（体现 accentColor 的功能性，而非装饰性）
                    Container(
                      width: 3,
                      height: 16,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title.toUpperCase(), // 标题大写化增强设计感
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        fontFamily: 'Roboto', // 建议使用非衬线字体
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 11),
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 右侧功能占位（可选）
          Opacity(
            opacity: 0.5,
            child: Icon(Icons.layers_outlined, color: accentColor, size: 18),
          ),
        ],
      ),
    );
  }
}