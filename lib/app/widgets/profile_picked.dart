import 'package:flutter/material.dart';

class PickerOption extends StatelessWidget {
  final IconData? icon;
  final String? imagePath; // 👈 add this
  final String label;
  final VoidCallback onTap;

  const PickerOption({
    this.icon,
    this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF3B6B5E).withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF3B6B5E).withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            // 👇 Replace Icon with Image if provided
            imagePath != null
                ? Image.asset(
              imagePath!,
              height: 28,
              width: 28,
              fit: BoxFit.contain,
            )
                : Icon(icon, color: const Color(0xFF3B6B5E), size: 28),

            const SizedBox(height: 8),

            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF3B6B5E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}