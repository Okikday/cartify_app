import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/models/user_model.dart';
import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  static final clientID = dotenv.env["CLIENT_ID"];
  static final serverClientID = dotenv.env["SERVER_CLIENT_ID"];


  static final GoogleSignIn googleUserAuth = GoogleSignIn(
    forceCodeForRefreshToken: true,
    clientId: clientID,
    serverClientId: serverClientID,
    scopes: [
      'email',
      'profile',
    ],
  );

  Future<String?> googleSignIn() async {
    try{

      final GoogleSignInAccount? googleUser = await googleUserAuth.signIn();

      if (googleUser == null) {
        return "Google Sign-In was canceled by the user.";
      }

      // Get the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      // Obtain the user's details from the GoogleSignInAccount
      final String? displayName = googleUser.displayName;
      final String email = googleUser.email;
      final String? photoURL = googleUser.photoUrl;

      if(idToken != null){
        await sendGoogleToken(idToken);
      }else{
        return "Error: No ID Token";
      }

      UserData().storeGoogleSignInDetails(
          idToken: idToken, accessToken: accessToken, displayName: displayName, email: email, photoURL: photoURL,);

      
      // If everything is successful, return null (no error)
      return null;
    } catch (e) {
      debugPrint("$e");
      return e.toString();
    }
  }

  Future<String?> sendGoogleToken(String idToken) async{
    try{
      final Response response = await dio.post(
        "$apiURL/api/v1/auth/google",
        data: {"token": idToken,},
      );

      if(response.statusCode == 200){
        final responseUser = response.data['payload']['user'];
        final userData = UserModel.fromMap(responseUser);

        UserData().storeUserApiKey(userData.apiKey);
        UserData().storeUserDetails(userID: userData.id, fullName: userData.fullName,);
        
        return null;

      }else if(response.statusCode == 404){
        debugPrint("Unable to access link");
        return "Unable to access link";

      }else{
      debugPrint("Unknown error occurred");
      return "Unknown error while adding user";
      }
    }catch(e){
      debugPrint("Unknown error occurred");
      return "Unknown error while adding user";
    }
  }

  Future<String?> googleSignOut() async {
    try {
      // Sign out the currently signed-in user
      await googleUserAuth.signOut();

      //clear details from secure storage
      await UserData().clearStoredGoogleSignInDetails();

      return null;
    } catch (e) {
      return e.toString();
    }
  }
  
}



