import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbix_chat/core/widgets/sphere/animated_obj.dart';
import 'package:orbix_chat/features/voice_input/presentation/cubit/voice_cubit.dart';

class VoiceInputScreen extends StatefulWidget {
  const VoiceInputScreen({super.key});

  @override
  State<VoiceInputScreen> createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends State<VoiceInputScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<SpherePoint> _points;
  bool _hasPopped = false;

  @override
  void initState() {
    super.initState();

    const int dotCount = 500;
    _points = List.generate(dotCount, (i) {
      double theta = acos(1 - 2 * (i + 0.5) / dotCount);
      double phi = pi * (1 + sqrt(5)) * i;
      return SpherePoint(theta, phi);
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    context.read<VoiceCubit>().startListening();
  }

  void _safePop(String text) {
    if (!_hasPopped && mounted) {
      _hasPopped = true;
      Navigator.pop(context, text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const baseRadius = 50.0;

    return BlocListener<VoiceCubit, VoiceState>(
      listener: (context, state) {
        if (state.isListening == false && state.text.isNotEmpty) {
          _safePop(state.text);
        }
      },
      child: BlocBuilder<VoiceCubit, VoiceState>(
        builder: (context, state) {
          final globeRadius = baseRadius + state.amplitude * 80;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: globeRadius * 2,
                  height: globeRadius * 2,
                  child: CustomPaint(
                    painter: GlobeDotsPainter(
                      animation: _controller,
                      radius: globeRadius,
                      points: _points,
                      amplitude: state.amplitude,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  state.text,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _safePop(state.text),
                child: const Text("OK"),
              ),
            ],
          );
        },
      ),
    );
  }
}
