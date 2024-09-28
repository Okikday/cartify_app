import 'package:cartify/common/constants/themes.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/views/authentication/check_user.dart';
import 'package:cartify/views/authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
    return MaterialApp(
      navigatorKey: globalNavKey,
      debugShowCheckedModeBanner: false,
      theme: CartifyThemes.lightTheme,
      darkTheme: CartifyThemes.darkTheme,
      home: const CheckUser(),
    );
  }
}
