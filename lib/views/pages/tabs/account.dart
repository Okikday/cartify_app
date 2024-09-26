import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  Account({super.key});

//Icon, title
  final List accountOptions = [
    [Icons.person, "Account details"],
    [Icons.add, "Buy and sell"],
    [Icons.payment_rounded, "Payment method"],
    [Icons.key, "Change Password"],
    [Icons.help_outline_rounded, "Support"],
    [Icons.star_border, "Rate the app"],
    [Icons.map, "Privacy Policy"],
    [Icons.info_outline_rounded, "About us"],
    [Icons.logout, "Log out"],
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = DeviceUtils.getScreenWidth(context);
    double screenHeight = DeviceUtils.getScreenHeight(context);

    return SizedBox(
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.1,
            width: screenWidth,
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: [
                Expanded(child: ConstantWidgets.text(context, "Account", fontSize: 18, fontWeight: FontWeight.bold)),
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
          ),
          Column(
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
                          color: CartifyColors.lightGray,
                          borderRadius: BorderRadius.circular(64),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/user.png"),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstantWidgets.text(context, "Alex Veranda", fontWeight: FontWeight.bold, adjustSize: 2),
                        const SizedBox(
                          height: 8,
                        ),
                        ConstantWidgets.text(context, "verandalex@gmail.com", color: CartifyColors.lightGray),
                        const SizedBox(
                          height: 8,
                        ),
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

              const SizedBox(
                height: 12,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth * 0.35,
                    decoration: BoxDecoration(color: CartifyColors.premiumGold.withAlpha(35), borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstantWidgets.text(context, "💼 Wallet", fontSize: 13,),
                        ConstantWidgets.text(context, "\$ 79.99", fontSize: 16, color: Colors.green),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24,),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth * 0.35,
                    decoration: BoxDecoration(color: CartifyColors.premiumGold.withAlpha(35), borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstantWidgets.text(context, "💰 Cashback", fontSize: 13,),
                        ConstantWidgets.text(context, "\$ 7.99", fontSize: 16, color: Colors.blue),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: ListView.builder(
                itemCount: accountOptions.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(
                    accountOptions[index][0],
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  title: ConstantWidgets.text(context, accountOptions[index][1]),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  onTap: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
