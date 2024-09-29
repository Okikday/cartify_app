import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {
  
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  
  Future<void> storeGoogleSignInDetails({
    required String? idToken, 
    required String? accessToken, 
    required String? displayName,
    required String? email,
    required String? photoURL,
    }) async{

     // Store tokens in secure storage
      if (idToken != null) await secureStorage.write(key: 'idToken', value: idToken);

      if (accessToken != null) await secureStorage.write(key: 'accessToken', value: accessToken);

      if (displayName != null) await secureStorage.write(key: 'displayName', value: displayName);

      if (email != null) await secureStorage.write(key: 'email', value: email);

      if (photoURL != null) await secureStorage.write(key: 'photoURL', value: photoURL);
  }

  Future<void> storeUserDetails({
    required String? userID,
    required String? fullName,
  }) async{
    if(userID != null) await secureStorage.write(key: 'userID', value: userID);

    if(fullName != null) await secureStorage.write(key: 'fullName', value: fullName);
  }

  Future<void> clearStoredGoogleSignInDetails() async {

    // Clear stored tokens and user information
    await secureStorage.delete(key: 'idToken');
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'displayName');
    await secureStorage.delete(key: 'email');
    await secureStorage.delete(key: 'photoURL');
    await secureStorage.delete(key: 'privateUserID');
    await secureStorage.delete(key: 'apiKey');
  }

  Future<void> clearUserDetails() async{
    await secureStorage.delete(key: 'userID');
    await secureStorage.delete(key: 'fullName');
  }

  Future<bool> isUserSignedIn() async{
    final idToken = await secureStorage.read(key: "idToken");
    return idToken != null;
  }

  Future<void> storeUserApiKey(String apiKey) async => secureStorage.write(key: 'apiKey', value: apiKey);

  Future<String?> getUserApiKey() async => secureStorage.read(key: 'apiKey');


}