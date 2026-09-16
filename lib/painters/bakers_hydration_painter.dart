import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/draliko_theme.dart';

class BakersHydrationPainter extends CustomPainter {
  final double hydrationPct; // e.g. 68.0 (%)
  final double totalFlourG;  // e.g. 1000 g

  BakersHydrationPainter({
    required this.hydrationPct,
    required this.totalFlourG,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background dough vessel bowl
    final bowlRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(16, 12, w - 32, h - 24),
      const Radius.circular(20),
    );
    final bowlPaint = Paint()
      ..color = DralikoTheme.edge.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(bowlRect, bowlPaint);

    final borderPaint = Paint()
      ..color = DralikoTheme.edge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(bowlRect, borderPaint);

    // Flour mass representation (bottom base)
    final flourH = (h - 24) * 0.45;
    final flourRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(20, h - 12 - flourH, w - 40, flourH),
      const Radius.circular(16),
    );
    final flourPaint = Paint()
      ..color = const Color(0xFFF5E6CA)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(flourRect, flourPaint);

    // Water level wave on top of flour
    final waterRatio = (hydrationPct / 100.0).clamp(0.4, 1.0);
    final waterLevelH = flourH * waterRatio;
    final wavePath = Path();
    wavePath.moveTo(20, h - 12 - flourH);
    for (double x = 20; x <= w - 20; x += 10) {
      final yOffset = sin((x / w) * pi * 4) * 3;
      wavePath.lineTo(x, h - 12 - flourH + yOffset);
    }
    wavePath.lineTo(w - 20, h - 12);
    wavePath.lineTo(20, h - 12);
    wavePath.close();

    final waterPaint = Paint()
      ..color = DralikoTheme.accentLight.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawPath(wavePath, waterPaint);

    // Hydration ratio line
    final markerY = h - 12 - waterLevelH;
    final markerPaint = Paint()
      ..color = DralikoTheme.accent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(28, markerY), Offset(w - 28, markerY), markerPaint);
  }

  @override
  bool shouldRepaint(covariant BakersHydrationPainter oldDelegate) {
    return oldDelegate.hydrationPct != hydrationPct ||
        oldDelegate.totalFlourG != totalFlourG;
  }
}
