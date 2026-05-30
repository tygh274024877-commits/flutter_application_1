import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/controller/ChatController.dart';

class ChatInputSection extends StatelessWidget {
  final ChatController controller;
  final TextEditingController textController;
  final bool isListening;
  final double soundLevel;
  final Color primaryColor;
  final Color backgroundColor;
  final VoidCallback onListenTap;
  final VoidCallback onSendTap;

  const ChatInputSection({
    Key? key,
    required this.controller,
    required this.textController,
    required this.isListening,
    required this.soundLevel,
    required this.primaryColor,
    required this.backgroundColor,
    required this.onListenTap,
    required this.onSendTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            if (controller.selectedImagePath.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.file(
                            File(controller.selectedImagePath.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.clearSelectedImage(),
                        child: const CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.camera_alt_rounded,
                              color: primaryColor,
                            ),
                            title: const Text('التقاط صورة بالكاميرا'),
                            onTap: () {
                              controller.pickImage(ImageSource.camera);
                              Get.back();
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.photo_library_rounded,
                              color: primaryColor,
                            ),
                            title: const Text('اختيار من الاستوديو'),
                            onTap: () {
                              controller.pickImage(ImageSource.gallery);
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: isListening
                        ? "جاري الاستماع صوتياً..."
                        : "اسأل جمني المطور أو أرسل صورة...",
                    hintStyle: TextStyle(color: primaryColor.withOpacity(0.4)),
                    filled: true,
                    fillColor: backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onListenTap,
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: isListening
                        ? primaryColor.withOpacity(0.15)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      padding: EdgeInsets.all(
                        isListening
                            ? (3 + soundLevel * 1.5).clamp(2.0, 12.0)
                            : 0,
                      ),
                      decoration: BoxDecoration(
                        color: isListening
                            ? primaryColor
                            : Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isListening
                            ? Icons.mic_rounded
                            : Icons.mic_none_rounded,
                        color: isListening ? Colors.white : primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : () {
                          if (textController.text.isNotEmpty ||
                              controller.selectedImagePath.value.isNotEmpty) {
                            onSendTap();
                          }
                        },
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: primaryColor,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
