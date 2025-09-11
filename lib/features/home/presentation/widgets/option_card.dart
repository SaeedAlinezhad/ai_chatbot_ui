import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;
  final IconData? icon;

  const OptionCard({
    required this.title,
    required this.description,
    required this.onTap,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // smaller padding
        decoration: BoxDecoration(
          color: const Color.fromARGB(57, 63, 57, 90),
          borderRadius: BorderRadius.circular(14), // smaller radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              CircleAvatar(
                radius: 18, // smaller avatar
                backgroundColor: Colors.white24,
                child: Icon(icon, color: Colors.white, size: 20), // smaller icon
              ),
            if (icon != null) const SizedBox(height: 8), // less spacing
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 14, // smaller text
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 11, // smaller description
                color: Colors.white70,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
