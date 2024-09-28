import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {
  
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
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
        await _secureStorage.write(key: 'idToken', value: idToken);
      }
      if (accessToken != null) {
        await _secureStorage.write(key: 'accessToken', value: accessToken);
      }
      if (displayName != null) {
        await _secureStorage.write(key: 'displayName', value: displayName);
      }
      if (email != null) {
        await _secureStorage.write(key: 'email', value: email);
      }
      if (photoURL != null) {
        await _secureStorage.write(key: 'photoURL', value: photoURL);
      }
      if (privateUserID != null){
        await _secureStorage.write(key: 'privateUserID', value: privateUserID);
      }
  }


}