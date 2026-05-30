import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final dynamic message; // بيفترض وجود .text و .isUser
  final Color primaryColor; // لون التطبيق الأساسي (للرسالة المرسلة)

  const ChatBubble({
    Key? key,
    required this.message,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUser = message.isUser;

    // تصميم مخصص للمستخدم: استخدام تدرج لوني عميق
    final Decoration userDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryColor.withOpacity(0.9), // لون فاتح قليلاً في الأعلى
          primaryColor, // اللون الأساسي في الأسفل
        ],
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(4), // حافة ناعمة جداً للذيل
      ),
      boxShadow: [
        // ظل سفلي ناعم لإعطاء عمق
        BoxShadow(
          color: primaryColor.withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(3, 6),
        ),
      ],
    );

    // تصميم مخصص للطرف الآخر: تأثير Glassmorphic زجاجي ناعم
    final Decoration otherDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(4), // حافة ناعمة جداً للذيل
        bottomRight: Radius.circular(20),
      ),
      boxShadow: [
        // ظل داخلي فاتح (ضوء)
        BoxShadow(
          color: Colors.white.withOpacity(0.9),
          blurRadius: 10,
          offset: const Offset(-4, -4),
        ),
        // ظل خارجي ناعم جداً (ظل)
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(4, 4),
        ),
      ],
    );

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ), // مسافات أكبر للراحة
        child: Container(
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width *
                0.72, // عرض أصغر وتصميم متناسق
          ),
          // اختيار الديكور بناءً على هوية المرسل
          decoration: isUser ? userDecoration : otherDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Text(
            message.text,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black87,
              fontSize: 15,
              fontWeight: isUser
                  ? FontWeight.w500
                  : FontWeight.normal, // خط أعرض قليلاً لرسائل المستخدم
              height: 1.4,
              letterSpacing: 0.1, // تحسين قراءة النص
            ),
          ),
        ),
      ),
    );
  }
}
