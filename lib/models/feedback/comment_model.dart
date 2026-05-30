class CommentModel {
  final String userName;
  final String commentText;
  final int rating;

  CommentModel({
    required this.userName,
    required this.commentText,
    required this.rating,
  });

  // دالة لتحويل البيانات القادمة من الـ API (JSON) إلى الكائن الخاص بنا
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userName: json['user_name'] ?? 'Anonymous',
      commentText: json['comment_text'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }

  // دالة لتحويل الكائن إلى JSON عند إرساله للـ API
  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'comment_text': commentText,
      'rating': rating,
    };
  }
}
