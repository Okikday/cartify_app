import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';

class ProductCard1 extends StatelessWidget {
  final String productID;
  final String productName;
  final String assetName;
  final String price;
  final String category;
  final double discountPercentage;
  final void Function() onTap;

  const ProductCard1(
      {super.key,
      required this.productName,
      required this.assetName,
      required this.price,
      required this.category,
      required this.productID,
      required this.onTap,
      required this.discountPercentage});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    return CustomBox(
      onTap: onTap,
      child: SizedBox(
        height: 180,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                    color: CartifyColors.royalBlue.withAlpha(40),
                  ),
                  height: 180,
                  width: screenWidth * 0.37,
                  child: CachedNetworkImage(
                    imageUrl: assetName,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: LoadingShimmer(
                        width: screenWidth * 0.35,
                        height: 160,
                      ),
                    ),
                    errorWidget: (context, url, error) => SizedBox(width: screenWidth * 0.35, height: 160, child: const Center(child: Icon(Icons.error))),
                  ),
                ),
                Visibility(
                  visible: discountPercentage > 0,
                  child: Positioned(
                    right: 4,
                    top: 1,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.fromLTRB(6, 4, 6, 2),
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                          color: Colors.yellow.withAlpha(75),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [BoxShadow(blurRadius: 2, offset: const Offset(2, 2), color: Colors.black.withOpacity(0.5))]),
                      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), child: ConstantWidgets.text(context, "${discountPercentage.truncate()}% off", color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 4, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 72,
                      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(color: CartifyColors.royalBlue.withAlpha(45), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          ConstantWidgets.text(
                            context,
                            "Vendor",
                          ),
                          const SizedBox(
                            width: 2.5,
                          ),
                          Icon(
                            Icons.stars,
                            size: 14,
                            color: isDarkMode ? CartifyColors.premiumGold : CartifyColors.royalBlue,
                          )
                        ],
                      ),
                    ),
                    ConstantWidgets.text(context, productName, fontSize: 12, fontWeight: FontWeight.bold, overflow: TextOverflow.clip),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        ConstantWidgets.text(context, price, fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                          margin: const EdgeInsets.only(bottom: 4, top: 4),
                          decoration: BoxDecoration(color: CartifyColors.premiumGold.withAlpha(40), borderRadius: BorderRadius.circular(2)),
                          child: ConstantWidgets.text(
                            context,
                            "available",
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        // Container(
                        // padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                        // margin: const EdgeInsets.only(bottom: 4, top: 4),
                        // decoration: BoxDecoration(color: CartifyColors.premiumGold.withAlpha(40), borderRadius: BorderRadius.circular(2)),
                        // child: ConstantWidgets.text(context, "Lagos",  ),
                        // ),
                      ],
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: ConstantWidgets.text(context, "5 hours ago", color: CartifyColors.battleshipGrey, fontSize: 10))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 4, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  // SizedBox(
                  //   width: 36, height: 36,
                  //   child: IconButton(

                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.bookmark_add_outlined,
                  //       color: Colors.black,
                  //       size: 20,
                  //     ),
                  //     style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.lightGray)),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
