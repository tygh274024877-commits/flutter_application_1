import 'package:flutter/material.dart';
// 👇 قمنا باستيراد ملف الألوان مباشرة هنا
import 'package:flutter_application_1/core/color/constants.dart';

class TopActionBar extends StatelessWidget {
  final Color primaryColor;
  final bool isVoiceModeEnabled;
  final VoidCallback onMenuTap;
  final VoidCallback onVoiceToggleTap;

  const TopActionBar({
    Key? key,
    required this.primaryColor,
    required this.isVoiceModeEnabled,
    required this.onMenuTap,
    required this.onVoiceToggleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            icon: Icons.menu_rounded,
            // 👇 هنا قمنا بإجبار الأيقونة أن تأخذ اللون الذهبي مباشرة من ملف الثوابت الخاص بك
            iconColor: AppColors.golden,
            onTap: onMenuTap,
          ),
          _buildActionButton(
            icon: isVoiceModeEnabled
                ? Icons.volume_up_rounded
                : Icons.volume_off_rounded,
            iconColor: isVoiceModeEnabled
                ? primaryColor
                : Colors.grey.withOpacity(0.6),
            onTap: onVoiceToggleTap,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }
}
