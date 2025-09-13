
import 'package:flutter/material.dart';
import '../../../../core/widgets/sphere/animated_obj.dart';
import 'option_card.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Center(child: Globe3DAnimation(radius: 50)),
          const SizedBox(height: 18),
          const Text(
            'Hi, Orbix Studio',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Give any command naturally, from generating image to scheduling meetings',
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
              children: const [
                OptionCard(
                  title: 'Generate Image',
                  description: 'Create AI-generated images from text prompts.',
                  icon: Iconsax.image_copy,
                  onTap: null,
                ),
                OptionCard(
                  title: 'Create Video',
                  description: 'Generate short videos automatically.',
                  icon: Iconsax.video_copy,
                  onTap: null,
                ),
                OptionCard(
                  title: 'Summarise Text',
                  description: 'Get concise summaries of long text content.',
                  icon: Iconsax.text_copy,
                  onTap: null,
                ),
                OptionCard(
                  title: 'Voice Input',
                  description: 'Convert your voice into text quickly.',
                  icon: Iconsax.voice_cricle_copy,
                  onTap: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
