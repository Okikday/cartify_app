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

final productsFutureProvider = FutureProvider<List<ProductModel>?>((ref) async {
  final products = await productServices.getProducts();
  if (products != null) products.shuffle();
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
      } else if (response.statusCode == 404) {
        debugPrint("No Products available");
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "No Products available");
        return null;
      } else {
        debugPrint("Error fetching products: ${response.statusMessage}");
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Failed to load products!");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
      if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Failed to load products!");
      return null;
    }
  }

  // Function to fetch a product using its ID
  Future<dynamic> getProductByID({required String id}) async {
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

  // Function to Review a product
  Future<String?> reviewProduct() async {
    final String? apiKey = await userData.getUserApiKey();
    if (apiKey == null) {
      if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Account error. Try logging out and in again");
    }


  }

}
