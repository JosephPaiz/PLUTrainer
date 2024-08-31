class Product {
  final int plu;
  final String name;

  Product({required this.plu, required this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      plu: json['plu'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plu': plu,
      'name': name,
    };
  }
}
