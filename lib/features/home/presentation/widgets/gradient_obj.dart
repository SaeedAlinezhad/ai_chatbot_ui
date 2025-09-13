
import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  const GradientCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.transparent,
            ],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn, 
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.3),
              radius: 1.0,
              colors: [
                Color.fromARGB(255, 97, 47, 125),
                Colors.transparent,
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
