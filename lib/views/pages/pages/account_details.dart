import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountDetails extends ConsumerStatefulWidget {
  const AccountDetails({super.key});

  @override
  ConsumerState<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends ConsumerState<AccountDetails> {
  final HiveData hiveData = HiveData();
  String? userImage;
  String? userName;
  String? userRole;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final String? image = await hiveData.getData(key: "photoURL");
    final String? name = await hiveData.getData(key: "displayName");
    final String? role = await hiveData.getData(key: "role");
    final String? number = await hiveData.getData(key: "phoneNumber");
    setState(() {
      userImage = image;
      userName = name ?? "Username not found";
      userRole = role ?? "Unable to load user role";
      phoneNumber = number ?? "000";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    CartifyColors.royalBlue,
                    CartifyColors.premiumGold,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: ConstantWidgets.text(
                  context,
                  userName == "Username not found" ? "Welcome" : "Welcome, $userName",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(4, 4),
                        color: CartifyColors.premiumGold.withOpacity(0.5),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        offset: Offset(-4, -4),
                        color: CartifyColors.royalBlue.withOpacity(0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: CartifyColors.lightGray,
                    backgroundImage: userImage == null ? const AssetImage("assets/images/user.png") : CachedNetworkImageProvider(userImage!),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstantWidgets.text(context, "Display name: $userName"),
                    ConstantWidgets.text(context, "Role: $userRole"),
                    ConstantWidgets.text(context, "Phone Number: $phoneNumber"),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomElevatedButton(
            onClick: ()=> DeviceUtils.showFlushBar(context, "Feature not yet implemented"),
            label: "Edit account",
            textSize: 14,
            backgroundColor: CartifyColors.royalBlue,
            screenWidth: 90,
          ),

          Expanded(child: Center(child: ConstantWidgets.text(context, "Other details"),))
        ],
      ),
    );
  }
}
