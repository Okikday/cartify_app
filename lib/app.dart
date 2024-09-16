import 'package:cartify/common/constants/themes.dart';
import 'package:cartify/views/authentication/sign_in.dart';
import 'package:flutter/material.dart';


final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavKey,
      debugShowCheckedModeBanner: false,
      theme: CartifyThemes.lightTheme,
      darkTheme: CartifyThemes.darkTheme,
      home: const SignIn(),
    );
  }
}
