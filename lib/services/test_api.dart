import 'package:cartify/models/products_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TestApi {

  final Dio dio = Dio();
  static const String apiURL = "https://cartify-api.onrender.com/api/v1/products";

  void testConnect() async{
    final dynamic response = await dio.get(apiURL,
    options: Options(

    ));

    try{
    if (response.statusCode == 200) {
      final List<dynamic> productsList = response.data['payload']['product'];
      
      final dynamic data = ProductsModels.fromMap(productsList[0]);
      print("Data fetched: ${data.userName}");
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }

    
  }
}