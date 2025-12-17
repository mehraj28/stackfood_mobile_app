// class Food {
//   final int id;
//   final String name;
//   final double price;
//   final String imageUrl;
//   final String description;

//   Food({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.imageUrl,
//     required this.description,
//   });

//   factory Food.fromJson(Map<String, dynamic> json) {
//     return Food(
//       id: json['id'],
//       name: json['name'],
//       price: double.parse(json['price'].toString()),
//       imageUrl: json['image_url'] ?? '',
//       description: json['description'] ?? '',
//     );
//   }
// }

class Food {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
