import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  static final GoogleSignIn googleUserAuth = GoogleSignIn(
    clientId: dotenv.env["CLIENT_ID"], scopes: <String>['email', 'profile',], );

  static Future<GoogleSignInAccount?> login() => googleUserAuth.signIn();
  static Future signOut() => googleUserAuth.signOut();

  Future<String?> googleSignIn() async {
    try{
      debugPrint("${dotenv.env["CLIENT_ID"]}");
      //Try signing in
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
      final String privateUserID = googleUser.id;

      if(idToken != null){
        await sendGoogleToken(idToken);
        debugPrint("Id token: $idToken");
      }else{
        debugPrint("Error: No ID Token");
        return "Error: No ID Token";
      }

      UserData().storeGoogleSignInDetails(
          idToken: idToken, accessToken: accessToken, displayName: displayName, email: email, photoURL: photoURL, privateUserID: privateUserID);

      
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
        debugPrint("Successfully added User");
        debugPrint("${response.data}");
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



