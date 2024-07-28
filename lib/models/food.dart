class Food {
  final String name;
  final String description;
  final int price;
  final String imagePath;
  final double rating;

  Food({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      description: json['description'],
      price: int.parse(json['price']),
      imagePath: json['image_path'],
      rating: double.parse(json['rating']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'image_path': imagePath,
        'rating': rating,
      };
}
