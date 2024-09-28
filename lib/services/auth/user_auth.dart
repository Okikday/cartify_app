import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/services/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  final GoogleSignIn _googleAuth = GoogleSignIn();

  Future<String?> googleSignIn() async {
    try {
      //Try signing in
      final GoogleSignInAccount? googleUser = await _googleAuth.signIn();

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

      UserData().storeGoogleSignInDetails(
          idToken: idToken, accessToken: accessToken, displayName: displayName, email: email, photoURL: photoURL, privateUserID: privateUserID);

      

      // If everything is successful, return null (no error)
      return null;
    } catch (e) {
      // Return the error message as a String in case of any failure
      return e.toString();
    }
  }

  void sendGoogleToken() {
    try{
      dio.post(
        "$apiURL/api/v1/auth/google",
        
      );
    }catch(e){

    }
  }
}



