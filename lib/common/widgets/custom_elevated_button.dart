//Custom Elevated Button
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final Color? backgroundColor;
  final double? elevation;
  final void Function()? onClick;
  final double? borderRadius;
  final double? textSize;
  final double pixelHeight;   //Use pixel height for the normal height, declare for pixel if you want more customization over size
  final double pixelWidth;   //.... width for the normal width
  final double? screenHeight;   //Use this for height with respect to the screen size
  final double? screenWidth;
  final Color? textColor;
  final BorderSide? side;
  const CustomElevatedButton({
    super.key,
    this.label,
    this.child,
    this.onClick,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.textSize,
    this.pixelHeight = 48,
    this.pixelWidth = 200,
    this.screenHeight,
    this.screenWidth,
    this.textColor,
    this.side
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth != null ? MediaQuery.of(context).size.width * (screenWidth! / 100) : pixelWidth,
      height: screenHeight != null ? MediaQuery.of(context).size.height * (screenHeight! / 100) : pixelHeight,
      child: ElevatedButton(
          onPressed: onClick,
          
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(backgroundColor ?? Theme.of(context).primaryColor),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
            overlayColor: WidgetStatePropertyAll(CartifyColors.gold.withOpacity(0.25)),
            elevation: WidgetStatePropertyAll(elevation),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 24) )),
            side: WidgetStatePropertyAll(side),
          ),
          child: child ?? Center(
            child: ConstantWidgets.text(context, label, fontSize: textSize ?? 8, color: textColor ?? Colors.white)
          ),
          ),
    );
  }
}


