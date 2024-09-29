import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';

class UserServices {

  static const String updateRoleUrl = '/api/v1/users/update-role';
  final UserData userData = UserData();
  final HiveData hiveData = HiveData();


  Future<String?> updateUserRole({
    required bool enableToVendor,
    String? address,
    String? phoneNumber,
  }) async{
    if(enableToVendor == true){
      if(address == null || address.length < 3) return "Please input your address";
      if(phoneNumber == null || phoneNumber.length < 5) return "Kindly Input your Phone Number";

      final String? apiKey = await userData.getUserApiKey();
      
      if(apiKey == null) return "account-error";
      try{
        print("$apiURL$updateRoleUrl");
        final Response response = await dio.put(
        "$apiURL$updateRoleUrl",
        data: {
          'address': address,
          'phoneNumber': phoneNumber,
        },
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Authorization': "Bearer $apiKey",
            'Content-Type': "application/json",
          },
        ),
      );

      if(response.statusCode == 200 && response.data['success'] == true){
        response.toString();
        //hiveData.setData(key: 'role', value: 'vendor');
        return null;
      }else{
        return response.toString();
      }
      }catch(error){
        return error.toString();
      }

      }else{
        return "Something went wrong.";
      }
      
    }
  }
