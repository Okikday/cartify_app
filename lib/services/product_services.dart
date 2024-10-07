import 'dart:io';

import 'package:cartify/app.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String getProductsUrl = "/api/v1/products";
const String uploadProductUrl = "/api/v1/vendor/product";

final productsFutureProvider = FutureProvider<List<ProductModel>?>((ref) async {
  final products = await productServices.getProducts();
  if(products != null) products.shuffle();
  return products;
});

final ProductServices productServices = ProductServices();

class ProductServices {
  final HiveData hiveData = HiveData();
  final UserData userData = UserData();

  // Function to fetch products
  Future<List<ProductModel>?> getProducts() async {
    try {
      final Response response = await dio.get("$apiURL$getProductsUrl");

      if (response.statusCode == 200) {
        final List<dynamic> productsList = response.data['payload']['product'];

        // Convert the response to a list of ProductModel
        return productsList.map((json) => ProductModel.fromMap(json)).toList();
      }else if(response.statusCode == 404){
        debugPrint("No Products available");
        if(globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "No Products available");
        return null;
      }else{
        debugPrint("Error fetching products: ${response.statusMessage}");
        if(globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Failed to load products!");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
      if(globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Failed to load products!");
      return null;
    }
  }

Future<String?> uploadProduct({
  required String productName,
  required List<File> imageFiles,
  required String productDetails,
  required int productPrice,
  required String category,
  required int units,
  double? discountPercentage,
}) async {
  final String? role = await hiveData.getData(key: 'role');
  if (role == null) return "User role not set. Try logging in again";
  if (role.toString() != "vendor") return "not-vendor";

  final String? apiKey = await userData.getUserApiKey();
  if (apiKey == null) return "Account error. Try logging in again";

  // Prepare the list of MultipartFiles
  List<MultipartFile> imageMultipartFiles = [];
  for (File imageFile in imageFiles) {
    imageMultipartFiles.add(
      await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.path.split('/').last,
    ));
  }

  // Prepare form data
  FormData formData = FormData.fromMap({
    "productName": productName,
    "productDetails": productDetails,
    "productPrice": productPrice,
    "category": category,
    "units": units,
    "discountPercentage": discountPercentage ?? 0,
    "productImage": imageMultipartFiles,
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


  Future<dynamic> getProductByID({required id}) async {
    try {
      final Response response = await dio.get("$apiURL$getProductsUrl/$id");

      if (response.statusCode == 200) {
        final ProductModel product = response.data['payload'];
        // ignore: avoid_print
        print("Gotten product: $product");

        return product;
      } else if (response.statusCode == 400) {
        return "Invalid Product ID";
      }
    } catch (e) {
      debugPrint("Error fetching product: $e");
      return "Error loading product";
    }
  }

}
