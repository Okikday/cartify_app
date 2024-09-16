import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
     final double screenHeight = DeviceUtils.getScreenHeight(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 24, ),
                  child: Align(alignment: Alignment.topLeft, child: BackButton()),
                ),

                SizedBox(height: screenHeight * 0.01,),

                //Top Text
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, ),
                  child: ConstantWidgets.text(context, "Create a new account", fontSize: 36, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: screenHeight * 0.05,),

                const ModTextField(
                  prefixIcon: FluentIcons.mail_16_filled,
                  hintText: "Enter your Full name",
                ),

                SizedBox(height: screenHeight * 0.025,),

                //Enter email textbox
                const ModTextField(
                  prefixIcon: FluentIcons.mail_16_filled,
                  hintText: "Enter your email",
                ),

                SizedBox(height: screenHeight * 0.025,),
                
                //Enter password textbox
                ModTextField(
                  prefixIcon: Icons.lock,
                  hintText: "Enter your password",
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FluentIcons.eye_12_filled,
                        color: CartifyColors.battleshipGrey,
                      )),
                ),

                SizedBox(height: screenHeight * 0.05,),

                CustomElevatedButton(
                  onClick: (){},
                  screenWidth: 90,
                  label: "Sign up",
                  textSize: 16,
                  elevation: 2,
                  borderRadius: 8,
                ),

                SizedBox(height: screenHeight * 0.1,),

                 CustomElevatedButton(
                  onClick: (){},
                  screenWidth: 90,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                  child: ConstantWidgets.text(context, "Continue without an account", fontSize: 16, color: Colors.black),
                ),

              ],
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
      hintStyle: const TextStyle(color: CartifyColors.battleshipGrey),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: CartifyColors.lightGray, width: 2), borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: CartifyColors.premiumGold, width: 3), borderRadius: BorderRadius.circular(12)),
    );
  }
}
