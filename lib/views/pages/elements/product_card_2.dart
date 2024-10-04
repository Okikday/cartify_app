import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';

class ProductCard2 extends StatelessWidget {
  final String productID;
  final String productName;
  final String assetName;
  final String price;
  final String category;
  final double discountPercentage;
  final void Function() onTap;
  const ProductCard2(
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
    return IntrinsicHeight(
      child: CustomBox(
        onTap: onTap,
        margin: EdgeInsets.zero,
        constraints: BoxConstraints(maxHeight: 400, maxWidth: screenWidth * 0.4, minHeight: 200),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(

            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                  color: CartifyColors.royalBlue.withAlpha(40),
                ),
                constraints: BoxConstraints(maxHeight: 250, minWidth: screenWidth * 0.45),
                child: CachedNetworkImage(
                  imageUrl: assetName,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: LoadingShimmer(
                      width: screenWidth * 0.4,
                      height: 160,
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(child: SizedBox(width: screenWidth * 0.35, height: 160, child: const Center(child: Icon(Icons.error)))),
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.fromLTRB(6, 2.5, 8, 2.5),
                  decoration: BoxDecoration(
                      color: Colors.black.withAlpha(200),
                      borderRadius: BorderRadius.circular(16),),
                  child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), child: Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 15, color: CartifyColors.premiumGold,),
                      ConstantWidgets.text(context, "4.8", color: Colors.white),
                    ],
                  )),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                   Wrap(
                    spacing: 8,
                    runSpacing: 2,
                    children: [
                      ConstantWidgets.text(context, price, color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold),
                      Visibility(
                        visible: discountPercentage > 0,
                        child: Container(
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                        decoration: BoxDecoration(
                            color: Colors.red.withAlpha(75),
                            borderRadius: BorderRadius.circular(3),),
                        child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), child: ConstantWidgets.text(context, "${discountPercentage.truncate()}% off", color: Colors.white)),
                                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  ConstantWidgets.text(context, productName, fontSize: 13, overflow: TextOverflow.clip),
                  const SizedBox(
                    height: 4,
                  ),
                 
                  const SizedBox(
                    height: 4,
                  ),
                  ConstantWidgets.text(context, category, fonstStyle: FontStyle.italic, color: Colors.blueGrey),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 24,
                    child: Align(alignment: Alignment.bottomRight, child: Container(
                      width: 72,
                      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
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
                    ),),)
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
