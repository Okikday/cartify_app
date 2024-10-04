import 'package:cartify/common/constants/themes.dart';
import 'package:cartify/views/authentication/check_user.dart';
import 'package:cartify/views/pages/elements/product_card_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


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
