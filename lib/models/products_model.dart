class Product {
  final int plu;
  final String name;
  final String? imageUrl;

  Product({
    required this.plu,
    required this.name,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      plu: json['plu'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plu': plu,
      'name': name,
      'image_url': imageUrl,
    };
  }
}
