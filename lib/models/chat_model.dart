// models/chat_model.dart

class ChatModel {
  final String text;
  final bool isUser; // true للمستخدم، false للبوت

  ChatModel({required this.text, required this.isUser});

  // تحويل الرسالة إلى Map ليتم حفظها كـ JSON
  Map<String, dynamic> toJson() => {'text': text, 'isUser': isUser};

  // استخراج الرسالة من JSON عند القراءة
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(text: json['text'] ?? '', isUser: json['isUser'] ?? true);
}

class ChatSessionModel {
  final String id;
  String title;
  List<ChatModel> messages;

  ChatSessionModel({
    required this.id,
    required this.title,
    required this.messages,
  });

  // تحويل الجلسة كاملة ورسائلها إلى Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'messages': messages.map((m) => m.toJson()).toList(),
  };

  // استخراج الجلسة ورسائلها كاملة عند القراءة
  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    var list = json['messages'] as List? ?? [];
    List<ChatModel> msgList = list.map((m) => ChatModel.fromJson(m)).toList();
    return ChatSessionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      messages: msgList,
    );
  }
}
