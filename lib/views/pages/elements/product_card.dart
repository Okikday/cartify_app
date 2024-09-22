import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: CartifyColors.lightGray),
        borderRadius: BorderRadius.circular(24),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenWidth * 0.35, maxHeight: 200),
              child: Image.asset("assets/images/iphone_15_pm.jpg")),
            Container(
              child: Column(
                children: [
                  ConstantWidgets.text(context, "#1,700,000"),
                  ConstantWidgets.text(context, "Iphone 15 Pro max"),
                  ConstantWidgets.text(context, "tags"),
                ],
              ),
            ),

            IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_add_outlined))
          ],
          ),
      ),
    );
  }
}