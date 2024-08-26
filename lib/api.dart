class MediaPosts {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;
  final String description;
  final Map<String,dynamic> rating;



  const MediaPosts({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
    required this.description,
  });

  factory MediaPosts.fromJson(Map<String, dynamic> json) {
    return MediaPosts(
        id: json['id'],
        title: json["title"],
        price: json['price'].toDouble(),
        image: json['image'],
        category:json['category'],
        rating: json['rating'],
      description: json['description'],


    );
  }
}