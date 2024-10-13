import 'package:hive/hive.dart';

part 'products_models.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String vendor;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final List<dynamic> photo;

  @HiveField(4)
  final String productDetails;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final double price;

  @HiveField(7)
  final int units;

  @HiveField(8)
  final double discountPercentage;

  @HiveField(9)
  final DateTime createdAt;

  @HiveField(10)
  final DateTime updatedAt;

  @HiveField(11)
  final Map<String, dynamic> averageRating;

  @HiveField(12)
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
      discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
    );
  }
}
