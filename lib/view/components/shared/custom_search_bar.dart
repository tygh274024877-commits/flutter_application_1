import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/view/components/shared/golden_widgets.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback onTap; // مشان تتحكمي شو بيصير لما يضغط عليه
  final String text;
  const CustomSearchBar({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "search_bar_hero",
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap, // استخدام التابع هنا
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 248, 234),
              borderRadius: BorderRadius.circular(35),
              boxShadow: AppShadows.neumorphicShadow,
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 3,
              ),
            ),
            child: Row(
              children: [
                GoldenGradientWrapper(
                  isImage: true,
                  child: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
