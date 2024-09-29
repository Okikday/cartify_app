import 'package:cartify/app.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/services/auth/user_auth.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/authentication/sign_in.dart';
import 'package:cartify/views/page_elements/loading_dialog.dart';
import 'package:cartify/views/pages/pages/upload_product.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  Account({super.key});

//Icon, title
  final List<Map<String, dynamic>> accountOptions = [
    {'icon': Icons.person, 'title': "Account details"},

    //Upload Product
    {'icon': Icons.add, 'title': "Upload Product", 'onTap': (){
      DeviceUtils.pushMaterialPage(globalNavKey.currentContext!, const UploadProduct());
    }},
    {'icon': Icons.payment_rounded, 'title': "Payment method"},
    {'icon': Icons.key, 'title': "Change Password"},
    {'icon': Icons.help_outline_rounded, 'title': "Support"},
    {'icon': Icons.star_border, 'title': "Rate the app"},
    {'icon': Icons.map, 'title': "Privacy Policy"},
    {'icon': Icons.info_outline_rounded, 'title': "About us"},

    //Log out
    {'icon': Icons.logout_rounded, 'title': "Log out", 'onTap': ()async{
      if(globalNavKey.currentContext!.mounted) showDialog(context: globalNavKey.currentContext!, builder: (context) => const LoadingDialog());
      final UserAuth userAuth = UserAuth();
      final String? signOut = await userAuth.googleSignOut();
      if(globalNavKey.currentContext!.mounted) signOut != null ? DeviceUtils.showFlushBar(globalNavKey.currentContext!, signOut) : (){};
      if(signOut == null) Navigator.pushReplacement(globalNavKey.currentContext!, MaterialPageRoute(builder: (context) => const SignIn()));
    }},
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
            margin: const EdgeInsets.only(
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
                  child: IconButton(
                    onPressed: (){
                    },
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
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
                    accountOptions[index]["icon"],
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  title: ConstantWidgets.text(context, accountOptions[index]["title"]),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  onTap: accountOptions[index]["onTap"] ?? (){},
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
