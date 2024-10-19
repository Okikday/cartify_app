import 'package:another_flushbar/flushbar.dart';
import 'package:cartify/app.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/logout_dialog.dart';
import 'package:cartify/views/pages/pages/account_details.dart';
import 'package:cartify/views/pages/pages/messages.dart';
import 'package:cartify/views/pages/pages/settings.dart';
import 'package:cartify/views/pages/pages/update_role.dart';
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
  final HiveData hiveData = HiveData();
//Icon, title
  final List<Map<String, dynamic>> accountOptions = [
    {
      'icon': Icons.settings_rounded,
      'title': "Preferences",
      'onTap': () {
        if (globalNavKey.currentContext!.mounted) DeviceUtils.pushMaterialPage(globalNavKey.currentContext!, const Settings());
      }
    },
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
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
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
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(isDarkMode ? const Color(0xFFE0C878).withAlpha(60) : const Color(0xFFC9A641).withAlpha(80),)),
                  onPressed: () {
                    DeviceUtils.pushMaterialPage(context, const AccountDetails());
                  },
                  icon: Icon(
                    FluentIcons.person_28_filled,
                    color: isDarkMode ? CartifyColors.richBlack : CartifyColors.royalBlue,
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
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
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
                  onTap: (){
                    DeviceUtils.pushMaterialPage(context, const Messages());
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
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
                  onTap: () => DeviceUtils.showFlushBar(context, "Lol!"),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
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
                  onTap: () async{
                    final String role = await hiveData.getData(key: 'role');
                    if(role != 'vendor'){
                      if(context.mounted) DeviceUtils.pushMaterialPage(context, const UpdateRole());
                    }else{
                    if(context.mounted) DeviceUtils.pushMaterialPage(context, const VendorMode());
                    if(context.mounted) DeviceUtils.showFlushBar(context, "Vendor Mode 🙋", position: FlushbarPosition.TOP);
                    }
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
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
                    decoration: BoxDecoration(color: isDarkMode ? const Color(0xFFE0C878).withAlpha(60) : const Color(0xFFC9A641).withAlpha(80), borderRadius: BorderRadius.circular(14)),
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
                    decoration: BoxDecoration(color: isDarkMode ? const Color(0xFFE0C878).withAlpha(60) : const Color(0xFFC9A641).withAlpha(80), borderRadius: BorderRadius.circular(14)),
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
                  contentPadding: const EdgeInsets.only(left: 12, right: 12),
                  leading: Icon(
                    accountOptions[index]["icon"],
                    color: CartifyColors.royalBlue,
                    size: 28,
                  ),
                  title: ConstantWidgets.text(context, accountOptions[index]["title"], fontWeight: FontWeight.bold),
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
