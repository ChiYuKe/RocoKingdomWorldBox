import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  bool shouldRepaint(covariant RadarChartPainter old) => 
      old.animationValue != animationValue || old.color != color;
}