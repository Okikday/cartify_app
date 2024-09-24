import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/product_card.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return Column(
      children: [
        
    InkWell(
      onTap: () {},
      overlayColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold.withOpacity(0.1)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: DeviceUtils.isDarkMode(context) == true ? CartifyColors.lightPremiumGold.withOpacity(0.25) : CartifyColors.lightPremiumGold.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CartifyColors.premiumGold.withOpacity(0.5), width: 2)
            ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.9, maxHeight: 300),
          child: IntrinsicHeight(
            child: Row(
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.35, maxHeight: 300),
                    child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset("assets/images/iphone_15_pm.jpg"), )),
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
                          ConstantWidgets.text(context, "iPhone 15 pro Max", fontSize: 14),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.cancel_sharp,
                                color: CartifyColors.lightGray,
                                size: 28,
                              ),
                              padding: const EdgeInsets.all(0),
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
                        label: "Buy",
                        borderRadius: 8,
                        textSize: 14,
                        backgroundColor: CartifyColors.premiumGold,
                        onClick: () {
                          DeviceUtils.showFlushBar(context, "Say hi");
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),


      ],
    );
  }
}