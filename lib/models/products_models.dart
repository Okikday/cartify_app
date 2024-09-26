class ProductsModels {
  final String id;
  final String name;

   ProductsModels({
    required this.id,
    required this.name,
  });

  String get productId => id;
  String get productName => name;

  factory ProductsModels.fromMap(Map<String, dynamic> json){

    return ProductsModels(id: json['_id'], name: json['name']);
  }
}