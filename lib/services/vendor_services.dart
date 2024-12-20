import 'dart:io';

import 'package:cartify/app.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/pages/update_role.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String uploadProductUrl = "/api/v1/vendor/product";
const String updateProductUrl = "/api/v1/vendor/product";
const String getVendorProductUrl = "/api/v1/vendor/products";
const String deleteProductsUrl = "/api/v1/vendor/products";
const String getVendorOrdersUrl = "/api/v1/vendor/products/orders";
const String acceptProductOrderUrl = "/api/v1/vendor/products/orders/{orderId}";

final VendorServices vendorServices = VendorServices();

class VendorServices {
  final HiveData hiveData = HiveData();
  final UserData userData = UserData();

  // Function to upload vendor Product
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
      imageMultipartFiles.add(await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ));
    }

    // Prepare form data
    final FormData formData = FormData.fromMap({
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

  // Function to update vendor Product
  Future<String?> updateProduct({
    required String productId,
    required String productName,
    required String productDetails,
    required int productPrice,
    required String category,
    required int units,
    required List<File> imageFiles,
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
      imageMultipartFiles.add(await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ));
    }

    // Prepare form data
    final FormData formData = FormData.fromMap({
      "productName": productName,
      "productDetails": productDetails,
      "productPrice": productPrice,
      "category": category,
      "units": units,
      "productImage": imageMultipartFiles,
      "discountPercentage": discountPercentage ?? 0,
    });

    // Make the PATCH request
    try {
      final Response response = await dio.patch(
        "$apiURL$updateProductUrl/$productId",
        data: formData,
        queryParameters: {
          "productId": productId,
        },
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

  // Function to fetch vendor products
  Future<List<ProductModel>?> getVendorProducts() async {
    
    final String? role = await hiveData.getData(key: 'role');
      if (role == null) {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "User role not set. Try logging in again");
        return null;
      }

      if (role.toString() != "vendor") {
        if (globalNavKey.currentContext!.mounted) {
          DeviceUtils.pushMaterialPage(globalNavKey.currentContext!, const UpdateRole());
          DeviceUtils.showFlushBar(globalNavKey.currentContext!, "You are not yet a vendor. Try updating role");
        }
        return null;
      }

      final String? apiKey = await userData.getUserApiKey();
      if (apiKey == null) {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Account error. Try logging out and in again");
        return null;
      }
      
    try {
      

      final Response response = await dio.get(
        "$apiURL$getVendorProductUrl",
        options: Options(
          validateStatus: (status) => true,
          headers: {
          'Authorization': "Bearer $apiKey",
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsList = response.data['payload']['product'];

        // Convert the response to a list of ProductModel
        return productsList.map((json) => ProductModel.fromMap(json)).toList();
      } else if (response.statusCode == 404) {
        debugPrint("No Products available");
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "You haven't uploaded any product yet");
        return null;
      } else {
        debugPrint("${response.data['message']}");
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "${response.data['message'] ?? "Failed to load vendor products"}");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
      if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Failed to load vendor products!");
      return null;
    }
  }


  Future<String?> deleteVendorProducts({
    required String productId,
  }) async{
    final String? role = await hiveData.getData(key: 'role');
      if (role == null) return "User role not set. Try logging in again";

      if (role.toString() != "vendor") {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.pushMaterialPage(globalNavKey.currentContext!, const UpdateRole());
        return "You are not yet a vendor. Try updating role";
      }

      final String? apiKey = await userData.getUserApiKey();
      if (apiKey == null) return "Account error. Try logging out and in again";

      try{
        final Response response = await dio.delete(
          "$apiURL$deleteProductsUrl",
          data: {
            "productIds": [productId]
          },
          options: Options(
          validateStatus: (status) => true,
          headers: {
          'Authorization': "Bearer $apiKey",
        }),

        );

        if(response.statusCode == 200 || response.data['success'] == true){
          return null;
        }else{
          return "Error: ${response.statusMessage}";
        }

      }catch(e){
        return e.toString();
      }
  }

  Future<List<ProductModel>?> getVendorOrders() async{

    final String? role = await hiveData.getData(key: 'role');
      if (role == null) {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "User role not set. Try logging in again");
        return null;
      }

      if (role.toString() != "vendor") {
        if (globalNavKey.currentContext!.mounted) {
          DeviceUtils.pushMaterialPage(globalNavKey.currentContext!, const UpdateRole());
          DeviceUtils.showFlushBar(globalNavKey.currentContext!, "You are not yet a vendor. Try updating role");
        }
        return null;
      }

      final String? apiKey = await userData.getUserApiKey();
      if (apiKey == null) {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Account error. Try logging out and in again");
        return null;
      }

          try {
      

      final Response response = await dio.get(
        "$apiURL$getVendorOrdersUrl",
        options: Options(
          validateStatus: (status) => true,
          headers: {
          'Authorization': "Bearer $apiKey",
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsList = response.data['payload']['product'];

        // Convert the response to a list of ProductModel
        return productsList.map((json) => ProductModel.fromMap(json)).toList();
      } else if (response.statusCode == 404) {
        debugPrint("No Product orders available");
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "You dont have any product orders");
        return null;
      } else {
        debugPrint("Error fetching products orders: ${response.data}");
        if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Failed to load product orders!");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching products orders: $e");
      if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Failed to load product orders!");
      return null;
    }

  }

  Future<String?> acceptProductOrder({required String orderId}) async{

    final String? role = await hiveData.getData(key: 'role');
    if (role == null) return "User role not set. Try logging in again";
    if (role.toString() != "vendor") return "not-vendor";

    final String? apiKey = await userData.getUserApiKey();
    if (apiKey == null) return "Account error. Try logging in again";

      // Make the POST request
    try {
      final Response response = await dio.post(
        "$apiURL$acceptProductOrderUrl/$orderId",
        queryParameters: {
          'version': "v1",
          'orderId': orderId,
        },
        data: {
          'orderStatus': "accepted"
        },
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Authorization': "Bearer $apiKey",
            'Content-Type': "application/json",
          },
        ),
      );
      if (response.statusCode == 201 || response.data['success'] == true) {
        return null;
      } else {
        return response.data['message'] ?? response.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  


}
