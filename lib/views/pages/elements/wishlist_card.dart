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
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    return CustomBox(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.9, maxHeight: 400),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.35, maxHeight: 500),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset("assets/images/iphone_15_pm.jpg"),
                    )),
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
                          ConstantWidgets.text(context, "iPhone 15 Pro Max", fontSize: 14, fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.cancel_sharp,
                                color: isDarkMode ? CartifyColors.lightGray : Colors.white,
                                size: 28,
                              ),
                              padding: const EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ConstantWidgets.text(context, "Mobile phone", color: CartifyColors.royalBlue),
                      ConstantWidgets.text(context, "#1,700,000", color: CartifyColors.premiumGold),
                      Container(
                        child: ConstantWidgets.text(context, "Descriptions"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                     
                      const SizedBox(
                        height: 8,
                      ),
                      CustomElevatedButton(
                        label: "Add to Bag",
                        borderRadius: 8,
                        textSize: 14,
                        side: BorderSide(width: 2, color: CartifyColors.aliceBlue.withAlpha(50)),
                        backgroundColor: CartifyColors.royalBlue,
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
      );
  }
}
