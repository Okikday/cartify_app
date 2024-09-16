import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/main_screen.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = DeviceUtils.getScreenHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 24,
              ),
              child: Row(
                children: [
                  const Align(alignment: Alignment.topLeft, child: BackButton()),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 36),
                    child: ConstantWidgets.text(
                      context,
                      "Authenticate account",
                      align: TextAlign.center,
                      adjustSize: 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
                ],
              ),
            ),

            SizedBox(
              height: screenHeight * 0.05,
            ),

            //Top Text
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: ConstantWidgets.text(context, "Verify your account", fontSize: 24, fontWeight: FontWeight.bold, color: CartifyColors.premiumGold),
            ),

            SizedBox(
              height: screenHeight * 0.05,
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: ConstantWidgets.text(
                context,
                "We just sent a code to your email. Input in the boxes below",
                fontSize: 14,
              ),
            ),

            SizedBox(
              height: screenHeight * 0.05,
            ),

            
            Container(height: 45, color:  Colors.blue, child: Text("Box would be here"),),

            SizedBox(
              height: screenHeight * 0.05,
            ),

            CustomElevatedButton(
                  onClick: (){DeviceUtils.pushMaterialPage(context, const MainScreen());},
                  screenWidth: 90,
                  label: "Verify Account",
                  textSize: 16,
                  elevation: 2,
                  borderRadius: 8,
                ),
          ],
        ),
      ),
    );
  }
}
