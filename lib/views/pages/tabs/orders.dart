import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/purchase_card.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return  Column(
      children: [
        const SizedBox(height: kToolbarHeight),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConstantWidgets.text(
              context,
              "Orders",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8,),

        Expanded(child: ListView.builder(itemCount: 10, itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: PurchaseCard(screenWidth: screenWidth,))))
      ],
    );
  }
}
