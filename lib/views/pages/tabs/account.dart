import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  Account({super.key});

//Icon, title
  final List AccountOptions = [
    [Icons.add, "Booking order and appointments"],
    [Icons.heart_broken, "Favorite barbers salon"],
    [Icons.payment_rounded, "Payment method"],
    [Icons.key, "Change Password"],
    [Icons.help_outline_rounded, "Support"],
    [Icons.star_border, "Rate the app"],
    [Icons.map, "Language"],
    [Icons.info_outline_rounded, "About us"],
    [Icons.logout, "Log out"],
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = DeviceUtils.getScreenWidth(context);
    double screenHeight = DeviceUtils.getScreenHeight(context);

    return SizedBox(
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.1,
                width: screenWidth,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                    children: [
                      Expanded(
                        child: ConstantWidgets.text(context, "Account")
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                              Icons.settings_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                      ),
                    ],
                  ),
              )),
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Column(
              children: [
                //The edit Account area
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 81,
                          height: 81,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(64),
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/barbera/images/alex.jpg"),
                              )),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         ConstantWidgets.text(context, "Alex Veranda"),
                          const SizedBox(height: 8,),
                          ConstantWidgets.text(context, "verandalex@gmail.com"),
                          const SizedBox(height: 8,),
                          MaterialButton(
                            minWidth: 220,
                            onPressed: () {},
                            color: CartifyColors.premiumGold,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text("Edit Account"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //The followers area
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Flex(
                    clipBehavior: Clip.hardEdge,
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ConstantWidgets.text(context, "128"),
                            ConstantWidgets.text(context, "Following", fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ConstantWidgets.text(context, "128"),
                            ConstantWidgets.text(context, "Followers", fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ConstantWidgets.text(context, "240"),
                            ConstantWidgets.text(context, "messages", fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12,),

                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    children: [
                      for(int i = 0; i < AccountOptions.length; i++)
                      ListTile(
                        leading: Icon(
                          AccountOptions[i][0],
                          color: Theme.of(context).colorScheme.primary,
                          size: 28,
                        ),
                        title: ConstantWidgets.text(context, AccountOptions[i][1]),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 28,
                        ),
                        onTap: (){},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



