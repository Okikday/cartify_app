import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return CustomBox(
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.9, maxHeight: 200),
          child: IntrinsicHeight(
            child: Row(
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.35, maxHeight: 200),
                    child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset("assets/images/iphone_15_pm.jpg"))),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstantWidgets.text(context, "iPhone 15 pro max", fontSize: 14),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel_sharp,
                                color: CartifyColors.lightGray,
                                size: 28,
                              ),
                              padding: EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                      ConstantWidgets.text(context, "Mobile phone", color: CartifyColors.lightGray),
                      ConstantWidgets.text(context, "#1,700,000", color: CartifyColors.premiumGold),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomElevatedButton(
                        label: "Add to Cart",
                        borderRadius: 8,
                        textSize: 14,
                        backgroundColor: CartifyColors.premiumGold,
                        onClick: () {
                          DeviceUtils.showFlushBar(context, "Say hi");
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),);
  }
}
