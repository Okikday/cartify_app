import 'dart:io';

import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String getProductsUrl = "/api/v1/products";
const String uploadProductUrl = "/api/v1/vendor/product";

final ProductServices productServices = ProductServices();

class ProductServices {
  final HiveData hiveData = HiveData();
  final UserData userData = UserData();

  // Function to fetch products
  Future<List<ProductsModels>> getProducts() async {
    try {
      final Response response = await dio.get("$apiURL$getProductsUrl");

      final List<dynamic> productsList = response.data['payload']['product'];

      // Convert the response to a list of ProductsModels
      return productsList.map((json) => ProductsModels.fromMap(json)).toList();
    } catch (e) {
      debugPrint("Error fetching products: $e");
      throw Exception("Failed to load products");
    }
  }

//Function to Upload product
  Future<String?> uploadProduct({
    required String productName,
    required File imageFile,
    required String productDetails,
    required int productPrice,
    required String category,
    required int units,
    required double discountPercentage,
  }) async {
    final String? role = await hiveData.getData(key: 'role');
    if (role == null) return "User role not set. Try logging in again";
    if (role.toString() != "vendor") return "not-vendor";

    final String? apiKey = await userData.getUserApiKey();
    if (apiKey == null) return "Account error. Try logging in again";

    // Prepare form data
    FormData formData = FormData.fromMap({
      "productName": productName,
      "productDetails": productDetails,
      "productPrice": productPrice,
      "category": category,
      "units": units,
      "discountPercentage": discountPercentage,
      "productImage": await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    // Make the POST request
    try {
      final Response response = await dio.post(
        "$apiURL$uploadProductUrl",
        data: formData,
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Authorization': "Bearer $apiKey",
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      if (response.statusCode == 201 || response.data['success'] == true) {
        return null;
      } else {
        return response.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}
