import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
                  child: Image.asset("assets/images/iphone_15_pm.jpg")),
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
