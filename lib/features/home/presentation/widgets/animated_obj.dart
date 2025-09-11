import 'dart:math';
import 'package:flutter/material.dart';

class Globe3DAnimation extends StatefulWidget {
  final double radius;
  final int dotCount;
  final bool cycling;
  final double speed;

  const Globe3DAnimation({
    Key? key,
    this.radius = 100,
    this.dotCount = 500,
    this.cycling = true,
    this.speed = 25.0, // default: 12s per rotation
  }) : super(key: key);

  @override
  State<Globe3DAnimation> createState() => _Globe3DAnimationState();
}

class _Globe3DAnimationState extends State<Globe3DAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_SpherePoint> _points;

  @override
  void initState() {
    super.initState();

    // Precompute sphere points (Fibonacci distribution)
    _points = [];
    for (int i = 0; i < widget.dotCount; i++) {
      double theta = acos(1 - 2 * (i + 0.5) / widget.dotCount);
      double phi = pi * (1 + sqrt(5)) * i;
      _points.add(_SpherePoint(theta, phi));
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
      _controller.value = 0; // static globe
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
      ),
      size: Size(size, size),
    );
  }
}

class GlobeDotsPainter extends CustomPainter {
  final Animation<double> animation;
  final double radius;
  final List<_SpherePoint> points;

  GlobeDotsPainter({
    required this.animation,
    required this.radius,
    required this.points,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rotation = animation.value * 2 * pi;

    final Paint dotPaint = Paint();

    for (var p in points) {
      // 3D coords
      double x = radius * sin(p.theta) * cos(p.phi + rotation);
      double y = radius * cos(p.theta);
      double z = radius * sin(p.theta) * sin(p.phi + rotation);

      // simple perspective (depth effect)
      double scale = (z + radius) / (2 * radius); // 0..1
      double dx = center.dx + x;
      double dy = center.dy + y;

      // color & size by depth
      dotPaint.color = const Color.fromARGB(255, 139, 40, 156).withOpacity(0.3 + 0.7 * scale);
      double dotSize = 0.5 + 0.5 * scale;

      canvas.drawCircle(Offset(dx, dy), dotSize, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _SpherePoint {
  final double theta;
  final double phi;
  _SpherePoint(this.theta, this.phi);
}
