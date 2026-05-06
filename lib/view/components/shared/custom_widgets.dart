import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/color/constants.dart';
import '../../../core/localization/changelocal.dart';

class TopHeaderActions extends StatefulWidget {
  const TopHeaderActions({super.key});
  @override
  State<TopHeaderActions> createState() => _TopHeaderActionsState();
}

class _TopHeaderActionsState extends State<TopHeaderActions> {
  bool isLangPressed = false;
  final LocaleController localeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTapDown: (_) => setState(() => isLangPressed = true),
              onTapUp: (_) => setState(() => isLangPressed = false),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isLangPressed
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: PopupMenuButton<String>(
                  color: AppColors.background,
                  icon: Icon(Icons.translate, color: AppColors.primary),
                  onSelected: (langCode) =>
                      localeController.changeLang(langCode),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'ar', child: Text('العربية')),
                    const PopupMenuItem(value: 'en', child: Text('English')),
                  ],
                ),
              ),
            ),
            Image.asset('assets/images/smal.png', height: 40),
          ],
        ),
      ),
    );
  }
}

// كود SocialButton يوضع هنا أيضاً كما هو
class SocialButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const SocialButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isPressed
                  ? AppColors.darkBrown
                  : AppColors.earthyBrown.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: isPressed ? AppColors.darkBrown : AppColors.earthyBrown,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
