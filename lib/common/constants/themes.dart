import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartifyThemes{
  static ThemeData lightTheme = ThemeData(
    splashColor: Colors.transparent,
    primaryColor: CartifyColors.premiumGold,
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: GoogleFonts.notoSansTextTheme(),
    scaffoldBackgroundColor: CartifyColors.antiFlashWhite,
    colorScheme: const ColorScheme.light(primary: CartifyColors.premiumGold)
    
  );

  static ThemeData darkTheme = ThemeData(
    splashColor: Colors.transparent,
    primaryColor: CartifyColors.premiumGold,
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: GoogleFonts.notoSansTextTheme(),
    scaffoldBackgroundColor: CartifyColors.jetBlack,
    colorScheme: const ColorScheme.dark(primary: CartifyColors.premiumGold)
  );

}