class ProductModel {
  final String id;
  final String vendor;
  final String name;
  final List<dynamic> photo;
  final String productDetails;
  final String category;
  final double price;
  final int units;
  final double discountPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> averageRating;
  final double? discountedPrice;

  ProductModel({
    required this.id,
    required this.vendor,
    required this.name,
    required this.photo,
    required this.productDetails,
    required this.category,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.averageRating = const {},
    this.units = 1,
    this.discountPercentage = 0,
    this.discountedPrice,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      vendor: json['vendor'],
      name: json['name'],
      photo: json['photo'],
      productDetails: json['productDetails'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      units: json['units'],
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      averageRating: json['averageRating'] ?? {},
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
    );
  }


}
