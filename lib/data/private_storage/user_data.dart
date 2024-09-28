import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {
  
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  
  Future<void> storeGoogleSignInDetails({
    required String? idToken, 
    required String? accessToken, 
    required String? displayName,
    required String? email,
    required String? photoURL,
    String? privateUserID,
    }) async{
     // Store tokens in secure storage
      if (idToken != null) {
        await secureStorage.write(key: 'idToken', value: idToken);
      }
      if (accessToken != null) {
        await secureStorage.write(key: 'accessToken', value: accessToken);
      }
      if (displayName != null) {
        await secureStorage.write(key: 'displayName', value: displayName);
      }
      if (email != null) {
        await secureStorage.write(key: 'email', value: email);
      }
      if (photoURL != null) {
        await secureStorage.write(key: 'photoURL', value: photoURL);
      }
      if (privateUserID != null){
        await secureStorage.write(key: 'privateUserID', value: privateUserID);
      }
  }

  Future<void> clearStoredGoogleSignInDetails() async {

    // Clear stored tokens and user information
    await secureStorage.delete(key: 'idToken');
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'displayName');
    await secureStorage.delete(key: 'email');
    await secureStorage.delete(key: 'photoURL');
    await secureStorage.delete(key: 'privateUserID');
  }

  Future<bool> isUserSignedIn() async{
    final idToken = await secureStorage.read(key: "idToken");
    return idToken != null;
  }

  // Future<void> storeUserAPIKey(Map userData) async{
  //   secureStorage.write(key: "user", value: userData);
  // }


}