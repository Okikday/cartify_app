import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomBox({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.2),  // Subtle cool frost
        border: Border.all(width: 2, color: CartifyColors.royalBlue.withAlpha(75)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: DeviceUtils.isDarkMode(context) == true ? 
        [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 0), blurStyle: BlurStyle.inner, spreadRadius: 2),]
         : [BoxShadow(color: CartifyColors.royalBlue.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 0), blurStyle: BlurStyle.inner, spreadRadius: 2),],
      ),
      child: InkWell(
        onTap: (){onTap == null ? (){} : onTap!();},
          overlayColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold.withAlpha(50)),
          borderRadius: BorderRadius.circular(8),
        child: child,
      ),
    );
  }
}