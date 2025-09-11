import 'dart:math';

import 'package:flutter/material.dart';

class GlobeDotsPainter extends CustomPainter {
  final Animation<double> animation;
  final double radius;
  final List<SpherePoint> points;
  final double amplitude;
  GlobeDotsPainter({
    required this.animation,
    required this.radius,
    required this.points,
    required this.amplitude,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rotation = animation.value * 2 * pi;
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final theta = points[i].theta;
      final phi = points[i].phi + rotation;

      final x = radius * sin(theta) * cos(phi);
      final y = radius * cos(theta);
      final z = radius * sin(theta) * sin(phi);

      final scale = ((z + radius) / (2 * radius)).clamp(0.0, 1.0);
      final dx = center.dx + x;
      final dy = center.dy + y;

      paint.color = Colors.purpleAccent.withOpacity(0.3 + 0.7 * scale);
      final dotSize = (1.0 + 0.5 * scale).clamp(0.5, 3.0)* (1+amplitude);

      canvas.drawCircle(Offset(dx, dy), dotSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant GlobeDotsPainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.animation != animation;
}
class SpherePoint {
  final double theta;
  final double phi;
  SpherePoint(this.theta, this.phi);
}
