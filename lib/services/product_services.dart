import 'dart:io';

import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductServices {
  // Function to fetch products
  Future<List<ProductsModels>> getProducts() async {
    final String productsApiURL = "$apiURL/api/v1/products";

    try {
      final Response response = await dio.get(productsApiURL);
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
    required String apiKey,
    required String productName,
    required File imageFile,
  }) async {
    // Prepare form data
    FormData formData = FormData.fromMap({
      "name": productName,
      "image": await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    // Make the POST request
    try {
      await dio.post(
        "$apiURL/api/v1/vendor/product",
        data: formData,
        options: Options(
          headers: {
            "accept": '',
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      return null;
    } catch (e) {
      return "Error uploading product";
    }
  }
}
