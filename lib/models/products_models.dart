class ProductsModels {
  final String id;
  final String name;

   ProductsModels({
    required this.id,
    required this.name,
  });

  String get userName => name;

  factory ProductsModels.fromMap(Map<String, dynamic> json){

    return ProductsModels(id: json['_id'], name: json['name']);
  }
}