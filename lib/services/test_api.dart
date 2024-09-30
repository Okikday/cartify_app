import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TestApi {

  
  //Test connection
  static Future<String?> testConnect() async {
    final String productsApiURL = "$apiURL/api/v1";
    debugPrint("Testing connect at : $productsApiURL");
    try {
      final dynamic response = await dio.get(productsApiURL, options: Options());

      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        // ignore: avoid_print
        print("Connected");
        return null;
      } else if (response.statusCode == 404) {
        debugPrint('Failed to fetch data: ${response.statusCode}');
        // ignore: avoid_print
        print("Failed to connect: ERROR 404");
        return "Unable to connect to server";
      } else{
        // ignore: avoid_print
        print("Unknown error occured!");
        return "An unknown error occured!";
      }

    } 
    catch (e) {
      debugPrint('Error: $e');
      // ignore: avoid_print
      print("Unknown error while connecting");
      return "Unable to connect to server";
    }

  }


}
