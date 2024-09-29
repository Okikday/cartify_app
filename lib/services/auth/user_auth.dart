import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/models/user_model.dart';
import 'package:cartify/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

 const String googleAuthSignInUrl = "/api/v1/auth/google";
 const String googleAuthSignOutUrl = "/api/v1/auth/sign-out";
 

class UserAuth {
  static final clientID = dotenv.env["CLIENT_ID"];
  static final serverClientID = dotenv.env["SERVER_CLIENT_ID"];
  final UserData userData = UserData();


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
        final result = await sendGoogleTokenToBackend(idToken);
        if(result != null) return result;
      }else{
        return "Error: No ID Token";
      }

      UserData().storeGoogleSignInDetails(
          googleIdToken: idToken, googleAccessToken: accessToken, displayName: displayName, email: email, photoURL: photoURL,);

      
      // If everything is successful, return null
      return null;
    } catch (e) {
      debugPrint("$e");
      return e.toString();
    }
  }

  Future<String?> sendGoogleTokenToBackend(String googleIdToken) async{
    try{
      final Response response = await dio.post(
        "$apiURL$googleAuthSignInUrl",
        data: {"token": googleIdToken,},
      );

      if(response.statusCode == 200){
        final responseUser = response.data['payload']['user'];
        final userDetails = UserModel.fromMap(responseUser);
        
        debugPrint(responseUser.toString());

        userData.storeUserApiKey(userDetails.apiKey);
        userData.storeUserDetails(userID: userDetails.id, fullName: userDetails.fullName, role: userDetails.role, 
        phoneNumber: int.tryParse(userDetails.phoneNumber) != null || int.tryParse(userDetails.phoneNumber) != 0 ? userDetails.phoneNumber : null,
        );
        
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
    await googleUserAuth.signOut();
    await userData.clearUserDetails();
    return null;
      
  }
  
}



