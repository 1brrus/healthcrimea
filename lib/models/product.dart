class Product {
  final int id;
  final String name;
  final String description;
  final String number;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      number: json['number'],
    );
  }
}
