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
    this.amplitude = 0.0,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rotation = animation.value * 2 * pi;
    final paint = Paint()..style = PaintingStyle.fill;

    for (var p in points) {
      final theta = p.theta;
      final phi = p.phi + rotation;

      final x = radius * sin(theta) * cos(phi);
      final y = radius * cos(theta);
      final z = radius * sin(theta) * sin(phi);

      final scale = ((z + radius) / (2 * radius)).clamp(0.0, 1.0);
      final dx = center.dx + x;
      final dy = center.dy + y;

      paint.color = const Color.fromARGB(255, 139, 40, 156)
          .withOpacity(0.3 + 0.7 * scale);
      final dotSize = ((1.0 + 0.5 * scale) * (1 + amplitude)).clamp(0.5, 3.0);

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

class Globe3DAnimation extends StatefulWidget {
  final double radius;
  final int dotCount;
  final bool cycling;
  final double speed;
  final double amplitude;

  const Globe3DAnimation({
    super.key,
    this.radius = 100,
    this.dotCount = 500,
    this.cycling = true,
    this.speed = 25.0,
    this.amplitude = 0.0,
  });

  @override
  State<Globe3DAnimation> createState() => _Globe3DAnimationState();
}

class _Globe3DAnimationState extends State<Globe3DAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<SpherePoint> _points;

  @override
  void initState() {
    super.initState();

    _points = [];
    for (int i = 0; i < widget.dotCount; i++) {
      double theta = acos(1 - 2 * (i + 0.5) / widget.dotCount);
      double phi = pi * (1 + sqrt(5)) * i;
      _points.add(SpherePoint(theta, phi));
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (widget.speed * 1000).toInt(),
      ),
    );

    if (widget.cycling) {
      _controller.repeat();
    } else {
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.radius * 2.5;
    return CustomPaint(
      painter: GlobeDotsPainter(
        animation: _controller,
        radius: widget.radius,
        points: _points,
        amplitude: widget.amplitude,
      ),
      size: Size(size, size),
    );
  }
}
