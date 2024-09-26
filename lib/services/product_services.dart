import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ProductServices{

  void getProducts() async{

    final String productsApiURL = "$apiURL/api/v1/products";


    final dynamic response = await dio.get(productsApiURL, options: Options());

    try{

      final List<dynamic> productsList = response.data['payload']['product'];
      final dynamic data = ProductsModels.fromMap(productsList[0]);
      debugPrint("Data fetched: ${data.name}");

    }catch(e){
      debugPrint("Error fetching products");
    }

  }

}