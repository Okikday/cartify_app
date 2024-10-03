import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
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
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstantWidgets.text(
                context,
                "Hello, ${userName == "Username not found" ? "" : userName}",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CartifyColors.royalBlue
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: CartifyColors.lightGray,
                  backgroundImage: userImage == null ? const AssetImage("assets/images/user.png") : CachedNetworkImageProvider(userImage!,),
                ),
                const SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  ConstantWidgets.text(context, "Name: $userName"),
                  ConstantWidgets.text(context, "Role: $userRole"),
                  ConstantWidgets.text(context, "Phone Number: $phoneNumber"),
                ],)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
