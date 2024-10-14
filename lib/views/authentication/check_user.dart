import 'package:cartify/app.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/views/authentication/sign_in.dart';
import 'package:cartify/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckUser extends ConsumerWidget {
  const CheckUser({super.key});

  checkUser()async{
    final isUserSignedIn = await UserData().isUserSignedIn();
    if(isUserSignedIn == true){
      Navigator.of(globalNavKey.currentContext!).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreen()));
    }else{
      Navigator.of(globalNavKey.currentContext!).pushReplacement(MaterialPageRoute(builder: (context) => const SignIn()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Checks If User is Logged In
    checkUser();

    return const Scaffold(
      extendBody: true,
      body: Center(child: SizedBox(
        width: 200,
        height: 200,
        child: CircularProgressIndicator())),
    );
  }
}