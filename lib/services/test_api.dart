import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TestApi {

  
  //Test connection
  void testConnect() async {
    final String productsApiURL = "$apiURL/api/v1";

    try {
      final dynamic response = await dio.get(productsApiURL, options: Options());

      if (response.statusCode == 200) {
        final content = response.data;
        debugPrint("Success ${content['status']}");
      } else if (response.statusCode == 404) {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }

    } 
    catch (e) {
      debugPrint('Error: $e');
    }

  }


}
