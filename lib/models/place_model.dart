class Place {
  final String title;
  final String location;
  final String imageUrl;

  Place({required this.title, required this.location, required this.imageUrl});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['image'] ?? '',
    );
  }
}
