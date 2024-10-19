import 'dart:developer';

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
const String reviewProductUrl = "/api/v1/reviews";

final productsFutureProvider = FutureProvider<List<ProductModel>?>((ref) async {
  final products = await productServices.getProducts(page: 1);
  if (products != null) products.shuffle();
  return products;
});

final ProductServices productServices = ProductServices();

class ProductServices {
  final HiveData hiveData = HiveData();
  final UserData userData = UserData();

  // Function to fetch products
  Future<List<ProductModel>?> getProducts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final Response response = await dio.get(
        "$apiURL$getProductsUrl",
        queryParameters: {
          'version': "v1",
          'page': page,
          'limit': limit,
        }
        );

      if (response.statusCode == 200) {
        final List<dynamic> productsList = response.data['payload']['product'];
        log(productsList.toString());
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
  Future<ProductModel?> getProductByID({required String id}) async {
    
    try {
      final Response response = await dio.get("$apiURL$getProductsUrl/$id");

      if (response.statusCode == 200) {
        ProductModel productAsModel = ProductModel.fromMap(response.data['payload']['product'][0]);

        return productAsModel;
      } else if (response.statusCode == 400) {
        if(globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Invalid Product ID");
        return null;
      }else{
         if(globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Invalid Product ID");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching product: $e");
      if(globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Error loading product");
        return null;
    }
  }

  // Function to Review a product
  Future<String?> reviewProduct({
    required String productId,
    required int rating,
    String review = ""

  }) async {
    final String? apiKey = await userData.getUserApiKey();
    if (apiKey == null) {
      if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Account error. Try logging out and in again");
    }

    try{
      final Response response = await dio.post(
      "$apiURL$reviewProductUrl/$productId",
      data: {
        'rating': rating,
        "review": review,
      },
      options: Options(
        validateStatus: (status) => true,
          headers: {
            'Authorization': "Bearer $apiKey",
            "Content-Type": "application/json",
          },
      ),
      queryParameters: {
        "productId": productId,
      },
    );

    if(response.statusCode == 201 || response.data['success'] == true){
      return null;
    }else{
      debugPrint(response.statusMessage);
      return "Unable to add review";
    }

    }catch(e){
      debugPrint(e.toString());
      return "Unable to add review";
    }
  }

}
