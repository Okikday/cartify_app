import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {

  
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  static var data = HiveData.box;
  final hiveData = HiveData();
  
  Future<void> storeGoogleSignInDetails({
    required String? googleIdToken, 
    required String? googleAccessToken, 
    required String? displayName,
    required String? email,
    required String? photoURL,
    }) async{

      

     // Store tokens in secure storage
      if (googleIdToken != null) await secureStorage.write(key: 'googleIdToken', value: googleIdToken);

      if (googleAccessToken != null) await secureStorage.write(key: 'googleAccessToken', value: googleAccessToken);

      if (displayName != null) hiveData.setData(key: 'displayName', value: displayName);

      if (email != null) hiveData.setData(key: 'email', value: email);

      if (photoURL != null) hiveData.setData(key: 'photoURL', value: photoURL);
  }

  Future<void> storeUserDetails({
    required String? userID,
    required String? fullName,
    String? role,
    String? phoneNumber,

  }) async{
    if(userID != null) await secureStorage.write(key: 'userID', value: userID);

    if(fullName != null) await hiveData.setData(key: 'fullName', value: fullName);

    if(role != null) await hiveData.setData(key: 'role', value: role);

    if(phoneNumber != null) await hiveData.setData(key: 'phoneNumber', value: phoneNumber);
    
  }

  Future<void> clearStoredGoogleSignInDetails() async {

    // Clear stored tokens and user information
    await secureStorage.delete(key: 'googleIdToken');
    await secureStorage.delete(key: 'googleAccessToken');
    hiveData.deleteData(key: 'displayName');
    hiveData.deleteData(key: 'email');
    hiveData.deleteData(key: 'photoURL');
    hiveData.deleteData(key: 'privateUserID');

  }

  Future<void> clearUserDetails() async{
    await secureStorage.delete(key: 'userID');
    await secureStorage.delete(key: 'fullName');
    await secureStorage.delete(key: 'apiKey');
    clearStoredGoogleSignInDetails();
    clearProducts();
  }

  Future<void> clearProducts() async{
    await hiveData.deleteData(key: "wishlistsData");
  }

  Future<bool> isUserSignedIn() async => await getUserApiKey() != null;

  Future<void> storeUserApiKey(String apiKey) async => secureStorage.write(key: 'apiKey', value: apiKey);

  Future<String?> getUserApiKey() async => secureStorage.read(key: 'apiKey');


}