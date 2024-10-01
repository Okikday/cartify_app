// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_Textfield.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/services/auth/user_auth.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/authentication/sign_up.dart';
import 'package:cartify/views/main_screen.dart';
import 'package:cartify/views/page_elements/loading_dialog.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  static DateTime? lastBackPressTime;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    DeviceUtils.setStatusBarColor(Theme.of(context).scaffoldBackgroundColor, DeviceUtils.isDarkMode(context) == true ? Brightness.light : Brightness.dark);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult:(didPop, result){

        DateTime now = DateTime.now();

        if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(milliseconds: 2500)) {
          lastBackPressTime = now;
          DeviceUtils.showFlushBar(context, "Swipe or click back again to exit!");
        }else{
          SystemNavigator.pop();
        }
        
      },
      
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 80),
              child: Column(
                children: [
                  //Top Text
                  ConstantWidgets.text(context, "Login to your account", fontSize: 20, fontWeight: FontWeight.bold,),
      
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  //Enter email textbox
                  ModTextField(
                    prefixIcon: FluentIcons.mail_16_filled,
                    hintText: "Enter your email",
                  ),
      
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  //Enter password textbox
                  ModTextField(
                    prefixIcon: Icons.lock,
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FluentIcons.eye_12_filled,
                          color: CartifyColors.battleshipGrey,
                        )),
                  ),
      
                  Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: ConstantWidgets.text(context, "Forgot password?"))),
      
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  CustomElevatedButton(
                    onClick: () {},
                    screenWidth: 90,
                    label: "Sign in",
                    textSize: 16,
                    elevation: 2,
                    borderRadius: 8,
                  ),
      
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: CartifyColors.lightGray,
                          thickness: 2,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ConstantWidgets.text(
                            context,
                            "or",
                            adjustSize: 2,
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          color: CartifyColors.lightGray,
                          thickness: 2,
                        ))
                      ],
                    ),
                  ),
      
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  CustomElevatedButton(
                    onClick: () async {
                      if (context.mounted){
                        showDialog(
                            context: context,
                            builder: (context) => const LoadingDialog());
                      }
                      final String? signInOutcome = await UserAuth().googleSignIn();
                      if (signInOutcome == null) {
                        if (context.mounted) Navigator.pop(context);
      
                        if (context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      } else {
                        if (context.mounted) Navigator.pop(context);
                        if (context.mounted) DeviceUtils.showFlushBar(context, signInOutcome);
                      }
                    },
                    screenWidth: 90,
                    backgroundColor: Colors.white,
                    elevation: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: SizedBox(width: 20, height: 20, child: Image.asset("assets/icons/google_logo.png")),
                        ),
                        ConstantWidgets.text(context, "Continue with Google", fontSize: 16, color: Colors.black),
                      ],
                    ),
                  ),
      
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  CustomElevatedButton(
                    onClick: () {DeviceUtils.showFlushBar(context, "Feature coming soon!");},
                    screenWidth: 90,
                    backgroundColor: Colors.white,
                    elevation: 2,
                    side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                    child: ConstantWidgets.text(context, "Continue without an account", fontSize: 16, color: Colors.black),
                  ),
      
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstantWidgets.text(context, "Don't have an account?", adjustSize: 4),
                      TextButton(
                          onPressed: () {
                            DeviceUtils.pushMaterialPage(context, SignUp());
                          },
                          style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                          child: ConstantWidgets.text(context, "Sign up", color: Theme.of(context).primaryColor, adjustSize: 4))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ModTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final String hintText;
  const ModTextField({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      hint: hintText,
      screenWidth: 90,
      pixelHeight: 56,
      prefixIcon: prefixIcon == null
          ? null
          : Icon(
              prefixIcon,
              color: CartifyColors.battleshipGrey,
            ),
      suffixIcon: suffixIcon,
      alwaysShowSuffixIcon: true,
      backgroundColor: Colors.white,
      hintStyle: TextStyle(color: CartifyColors.battleshipGrey),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: CartifyColors.lightGray, width: 2), borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CartifyColors.premiumGold, width: 3), borderRadius: BorderRadius.circular(12)),
    );
  }
}
