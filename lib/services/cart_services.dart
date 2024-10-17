import 'package:cartify/app.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String addProductToCartUrl = "/api/v1/carts";
const String getUserCartsUrl = "/api/v1/carts";


class CartServices {
  final HiveData hiveData = HiveData();
  final UserData userData = UserData();

  Future<String?> addProductToCart({
    required String productId,
    required int quantity,
  }) async {
    final String? role = await hiveData.getData(key: 'role');
    if (role == null) return "User role not set. Try logging in again";
    final String? apiKey = await userData.getUserApiKey();
    if (apiKey == null) return "Account error. Try logging in again";

    try{
      final Response response = await dio.post(
      "$apiURL$addProductToCartUrl",
      data: {
        "productId": productId,
        "quantity": quantity,
      },
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Authorization': "Bearer $apiKey",
        },
      ),
    );
    
    if(response.statusCode == 201){
      return null;
    }else if(response.statusCode == 403){
      return response.data['message'] ?? "Product is currently out of stock or insufficient stock";
    }else{
      return "Unable to add product to cart";
    }
    }catch(e){
      return e.toString();
    }
  }

  Future<List<ProductModel>?> getUserCarts() async{
    final String? role = await hiveData.getData(key: 'role');
      if (role == null) {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "User role not set. Try logging in again");
        return null;
      }

      final String? apiKey = await userData.getUserApiKey();
      if (apiKey == null) {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Account error. Try logging out and in again");
        return null;
      }

    try{
      final Response response = await dio.get(
      "$apiURL$addProductToCartUrl",
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Authorization': "Bearer $apiKey",
        },
      ),
    );


    
    if(response.statusCode == 200){
      final List<dynamic> productsList = response.data['payload']['product'];

        // Convert the response to a list of ProductModel
        return productsList.map((json) => ProductModel.fromMap(json)).toList();
    }else if(response.statusCode == 404){
      debugPrint("No Products available");
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "User hasn't added product to Carts");
    }else{
      if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Unable to load cart");
    }
    }catch(e){
      if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, e.toString());
    }
  }
}
