import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/AiTransLator_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class InteractiveOcrScreen extends GetView<AiTranslatorController> {
  const InteractiveOcrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text("اضغط لتحديد نص"),
        backgroundColor: AppColors.primary,
        actions: [
          TextButton(
            onPressed: () => controller.translateAll(),
            child: const Text(
              "ترجمة الكل",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          if (controller.imageFile.value == null) {
            return const CircularProgressIndicator();
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              double viewWidth = constraints.maxWidth;
              double viewHeight = constraints.maxHeight;
              double imgWidth = controller.imageSize.value.width;
              double imgHeight = controller.imageSize.value.height;
              double scale = (viewWidth / imgWidth < viewHeight / imgHeight)
                  ? viewWidth / imgWidth
                  : viewHeight / imgHeight;
              double renderedWidth = imgWidth * scale;
              double renderedHeight = imgHeight * scale;
              double offsetX = (viewWidth - renderedWidth) / 2;
              double offsetY = (viewHeight - renderedHeight) / 2;

              return Stack(
                children: [
                  Center(
                    child: Image.file(
                      controller.imageFile.value!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: offsetX,
                    top: offsetY,
                    width: renderedWidth,
                    height: renderedHeight,
                    child: Stack(
                      children: controller.recognizedBlocks.map((block) {
                        final rect = block.boundingBox;
                        return Positioned(
                          left: rect.left * scale,
                          top: rect.top * scale,
                          width: rect.width * scale,
                          height: rect.height * scale,
                          child: GestureDetector(
                            onTap: () =>
                                controller.selectTextFromImage(block.text),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.3),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
