import 'package:flutter/material.dart';

class CircleActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active, isMain;

  const CircleActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: EdgeInsets.all(isMain ? 18 : 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? Colors.redAccent
                  : (isMain ? const Color(0xFFD2775B) : Colors.white),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            child: Icon(
              icon,
              color: (isMain || active)
                  ? Colors.white
                  : const Color(0xFFD2775B),
              size: isMain ? 32 : 26,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF65554E),
          ),
        ),
      ],
    );
  }
}
