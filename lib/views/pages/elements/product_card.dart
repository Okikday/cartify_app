import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String assetName;
  final String price;

  const ProductCard({super.key, required this.assetName, required this.price});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return CustomBox(child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenWidth * 0.35, maxHeight: 200),
                  child: CachedNetworkImage(imageUrl: assetName, fit: BoxFit.cover, placeholder: (context, url) => const CircleAvatar(backgroundColor: Colors.transparent, child: CircularProgressIndicator()), errorWidget: (context, url, error) => const Icon(Icons.error),),
                  ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right:16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstantWidgets.text(context, "#1,700,000", fontSize: 16, color: Colors.green),
                      const SizedBox(height: 8,),
                      ConstantWidgets.text(context, "iPhone 15 Pro max", fontSize: 12),
                      const SizedBox(height: 8,),
                      ConstantWidgets.text(context, "tags tags sold out available", color: CartifyColors.battleshipGrey),
                    ],
                  ),
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(onPressed: (){},  icon: const Icon(Icons.bookmark_add_outlined, color: Colors.black,), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.lightGray)),),
              )
            ],
            ),
        ),);
  }
}
