import 'package:cartify/app.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/logout_dialog.dart';
import 'package:cartify/views/pages/pages/account_details.dart';
import 'package:cartify/views/pages/pages/upload_product.dart';
import 'package:cartify/views/pages/pages/vendor_mode.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Account extends ConsumerStatefulWidget {
  const Account({super.key});

  @override
  ConsumerState<Account> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
//Icon, title
  final List<Map<String, dynamic>> accountOptions = [
    {
      'icon': Icons.person,
      'title': "Account details",
      'onTap': () {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.pushMaterialPage(globalNavKey.currentContext!, const AccountDetails());
      }
    },
    {'icon': FluentIcons.person_24_regular, 'title': "Vendor Mode"},
    {'icon': Icons.key, 'title': "Change Password"},
    {'icon': Icons.help_outline_rounded, 'title': "Support"},
    {'icon': Icons.star_border, 'title': "Rate the app"},
    {'icon': Icons.map, 'title': "Privacy Policy"},
    {'icon': Icons.info_outline_rounded, 'title': "About us"},

    //Log out
    {
      'icon': Icons.logout_rounded,
      'title': "Log out",
      'onTap': () {
        if(globalNavKey.currentContext!.mounted) showDialog(context: globalNavKey.currentContext!, builder: (context) => const LogoutDialog());
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    return SizedBox(
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.1,
            width: screenWidth,
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: [
                Expanded(child: ConstantWidgets.text(context, "Account", fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.premiumGold.withAlpha(50))),
                  onPressed: () {},
                  icon: const Icon(
                    FluentIcons.settings_24_filled,
                    color: CartifyColors.royalBlue,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 96,
            width: screenWidth,
            padding: const EdgeInsets.only(left: 12, right: 12),
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? CartifyColors.royalBlue.withAlpha(100) : CartifyColors.royalBlue.withAlpha(100),
              borderRadius: BorderRadius.circular(16),
              border: isDarkMode == false ? Border.all(width: 2, color: CartifyColors.onyxBlack.withAlpha(25)) : null,
              boxShadow: isDarkMode
                  ? [
                      const BoxShadow(color: CartifyColors.royalBlue, blurStyle: BlurStyle.outer, offset: Offset(1, 1), blurRadius: 4),
                      const BoxShadow(color: CartifyColors.royalBlue, blurStyle: BlurStyle.outer, offset: Offset(-1, -1), blurRadius: 4)
                    ]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){},
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            
                            backgroundColor: isDarkMode ? CartifyColors.premiumGold.withAlpha(50) : CartifyColors.royalBlue.withAlpha(100),
                            
                            child:  const Icon(
                              Icons.message_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4,),
                          ConstantWidgets.text(context, "Messages", color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){ },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            
                            backgroundColor: isDarkMode ? CartifyColors.premiumGold.withAlpha(50) : CartifyColors.royalBlue.withAlpha(100),
                            
                            child:  const Icon(
                              Icons.branding_watermark_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4,),
                          ConstantWidgets.text(context, "Post Ads", color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    DeviceUtils.pushMaterialPage(context, const UploadProduct());
                    DeviceUtils.showFlushBar(context, "Vendor Mode 🙋");
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            
                            backgroundColor: isDarkMode ? CartifyColors.premiumGold.withAlpha(50) : CartifyColors.royalBlue.withAlpha(100),
                            
                            child:  const Icon(
                              Icons.upgrade_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4,),
                          ConstantWidgets.text(context, "Sell Product", color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    // final String role = await HiveData().getData(key: 'role');
                    // if(role != 'vendor'){}
                    // if(context.mounted) DeviceUtils.pushMaterialPage(context, const VendorMode());
                    // if(context.mounted) DeviceUtils.showFlushBar(context, "Vendor Mode 🙋");
                    DeviceUtils.pushMaterialPage(context, const VendorMode());
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: isDarkMode ? CartifyColors.premiumGold.withAlpha(50) : CartifyColors.royalBlue.withAlpha(100),
                            child:  const Icon(
                              FluentIcons.person_28_filled,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4,),
                          ConstantWidgets.text(context, "Vendor Mode", color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth * 0.35,
                    decoration: BoxDecoration(color: CartifyColors.premiumGold.withAlpha(50), borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstantWidgets.text(context, "💼 Wallet", fontSize: 13, fontWeight: FontWeight.bold),
                        const SizedBox(
                          height: 8,
                        ),
                        ConstantWidgets.text(context, "\$ 79.99", fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth * 0.35,
                    decoration: BoxDecoration(color: CartifyColors.premiumGold.withAlpha(35), borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstantWidgets.text(context, "💰 Cashback", fontSize: 13, fontWeight: FontWeight.bold),
                        const SizedBox(
                          height: 8,
                        ),
                        ConstantWidgets.text(context, "\$ 14.99", fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
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
                    accountOptions[index]["icon"],
                    color: CartifyColors.royalBlue,
                    size: 28,
                  ),
                  title: ConstantWidgets.text(context, accountOptions[index]["title"]),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: CartifyColors.royalBlue,
                    size: 28,
                  ),
                  onTap: accountOptions[index]["onTap"] ?? () {},
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
