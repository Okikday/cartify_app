import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';

class ProductCard1 extends StatelessWidget {
  final String productID;
  final String assetName;
  final String price;
  final String category;

  const ProductCard1({
    super.key,
    required this.assetName,
    required this.price,
    required this.category,
    required this.productID
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return CustomBox(
      child: SizedBox(
        height: 180,
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                  color: CartifyColors.royalBlue.withAlpha(40)),
              height: 180,
              width: screenWidth * 0.37,
              //constraints: BoxConstraints(maxWidth: screenWidth * 0.37, maxHeight: 180),
              child: Image.asset(
                "assets/images/iphone_15_pm_nobg.png",
                fit: BoxFit.cover,
              ),
              //child: CachedNetworkImage(imageUrl: assetName, fit: BoxFit.cover, placeholder: (context, url) => const CircleAvatar(backgroundColor: Colors.transparent, child: CircularProgressIndicator()), errorWidget: (context, url, error) => const Icon(Icons.error),),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstantWidgets.text(context, "#1,700,000", fontSize: 16, color: Colors.green),
                    const SizedBox(
                      height: 8,
                    ),
                    ConstantWidgets.text(context, "iPhone 15 Pro max", fontSize: 12, fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 8,
                    ),
                    ConstantWidgets.text(context, "tags tags sold out available 5 hours ago", color: CartifyColors.battleshipGrey),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_add_outlined,
                  color: Colors.black,
                ),
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.lightGray)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
