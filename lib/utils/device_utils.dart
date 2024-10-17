import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DeviceUtils {

  //3. Check if device is tilted
  static bool isLandscapeOrientation(BuildContext context){
    var orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape ? true : false;
  }

  //4. Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }
  
  //5.
  static Future<bool> isMobileDevice(BuildContext context) async{
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }

  //6. 
  static bool isAndroid(){
    return Platform.isAndroid;
  }

  //7.
  static bool isIOS(){
    return Platform.isIOS;
  }

  //8. Check if device is connected
  static Future<bool> isConnected() async{
    try{
      final connection = await InternetAddress.lookup('example.com');
      return connection.isNotEmpty && connection[0].rawAddress.isNotEmpty;
    } on SocketException catch(_){
      return false;
    }
  }

  
  //9. Launch url
  static void launchUrl(String url) async {
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    } else{

    }
  }

  //10. Hide keyboard
  static void hideKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //11. Set Full Screen
  static void setFullScreen(bool enable){
    SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  //12. Show Statuc Bar
  static void showStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  //13. Check if device is in Dark mode
  static bool isDarkMode(context){
    return MediaQuery.of(context).platformBrightness == Brightness.dark ? true : false;
  }

  static void showFlushBar(BuildContext context, String msg, {
    int duration = 1500,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
    
  }) {
    if (context.mounted) {
      Flushbar(
        message: msg,
        duration: Duration(milliseconds: duration),
        animationDuration: const Duration(milliseconds: 500),
        flushbarPosition: position,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        borderRadius: BorderRadius.circular(36),
        backgroundColor: Colors.black.withOpacity(0.9),
        padding: const EdgeInsets.all(16),
      ).show(context);
    }
  }

  static void pushMaterialPage(BuildContext context, Widget page){
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushReplacementMaterialPage(BuildContext context, Widget page){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

    static bool isDeviceBig(BuildContext context) {
    if (MediaQuery.sizeOf(context).width > 500) {
      debugPrint("Device is big");
      return true;
    }
    return false;
  }

  static Future<void> setStatusBarColor(Color statusBarColor, Brightness iconBrightness) async{
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: statusBarColor, statusBarIconBrightness: iconBrightness)
    );
  }
  
  
}
