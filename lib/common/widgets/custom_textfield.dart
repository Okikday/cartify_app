import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String? hint; // Shows hint
  final String? label; // Shows Label
  final double pixelHeight; // Use pixel height for the normal height
  final double pixelWidth; // Use pixel width for the normal width
  final double? screenHeight; // Height based on screen size
  final double? screenWidth; // Width based on screen size
  final bool alwaysShowSuffixIcon; // Always show suffix icon if true
  final String defaultText; // Default text for the TextField
  final void Function()? ontap; // Tap action
  final void Function()? onTapOutside;
  final Function(String text)? onchanged; // Change listener for text
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final bool obscureText; // Toggle for password field
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final double borderRadius;
  final Color? backgroundColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final int maxLines;
  final bool isEnabled;

  const CustomTextfield({
    super.key,
    this.hint,
    this.label,
    this.screenHeight,
    this.screenWidth,
    this.alwaysShowSuffixIcon = false,
    this.defaultText = "",
    this.ontap,
    this.onTapOutside,
    this.onchanged,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.pixelHeight = 48,
    this.pixelWidth = 200,
    this.obscureText = false,
    this.hintStyle,
    this.labelStyle,
    this.inputTextStyle,
    this.borderRadius = 8,
    this.backgroundColor,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.controller,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.focusNode,
    this.maxLines = 1,
    this.isEnabled = true
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    
    // Use widget's controller or create a new one
    controller = widget.controller ?? TextEditingController(text: widget.defaultText);
    
    // Use widget's focusNode or create a new one
    focusNode = widget.focusNode ?? FocusNode();

    // Add listeners
    controller.addListener(refreshSuffixIconState);
    focusNode.addListener(refreshSuffixIconState);

    // Update the suffix icon state initially
    refreshSuffixIconState();
  }

  @override
  void dispose() {
    // Remove listeners
    controller.removeListener(refreshSuffixIconState);
    focusNode.removeListener(refreshSuffixIconState);

    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void refreshSuffixIconState() {
    if (widget.alwaysShowSuffixIcon) {
      showSuffixIcon = true;
    } else {
      if (widget.suffixIcon != null && focusNode.hasFocus) {
        showSuffixIcon = controller.text.isNotEmpty;
      } else {
        showSuffixIcon = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.screenWidth != null
          ? MediaQuery.of(context).size.width * (widget.screenWidth! / 100)
          : widget.pixelWidth,
      height: widget.screenHeight != null
          ? MediaQuery.of(context).size.height * (widget.screenHeight! / 100)
          : widget.pixelHeight,
      child: TextField(
        enabled: widget.isEnabled,
        maxLines: widget.maxLines,
        textAlign: widget.textAlign,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        controller: controller,
        focusNode: focusNode,
        onChanged: (text) {
          setState(() {
            if (text.isNotEmpty) {
              refreshSuffixIconState();
            }
          });
          if (widget.onchanged != null) {
            widget.onchanged!(text);
          }
        },
        onTap: () {
          refreshSuffixIconState();
          if (widget.ontap != null) widget.ontap!();
        },
        onTapOutside: (e) {
          focusNode.unfocus();
          if (widget.onTapOutside != null) widget.onTapOutside!();
        },
        style: widget.inputTextStyle ?? TextStyle(color: DeviceUtils.isDarkMode(context) ? Colors.white : Colors.black),
        cursorColor: DeviceUtils.isDarkMode(context) ? Colors.white : Colors.black,
        cursorRadius: const Radius.circular(12),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: showSuffixIcon ? widget.suffixIcon : null,
          hintText: widget.hint,
          labelText: widget.label,
          labelStyle: widget.labelStyle ??
              TextStyle(
                color: DeviceUtils.isDarkMode(context) ? Colors.white : Colors.black,
              ),
          hintStyle: widget.hintStyle ??
              TextStyle(
                color: DeviceUtils.isDarkMode(context) ? Colors.white : Colors.black,
              ),
          filled: true,
          fillColor: widget.backgroundColor ?? Colors.transparent,
          contentPadding: widget.contentPadding ?? const EdgeInsets.all(16),
          enabledBorder: widget.enabledBorder ?? defaultBorder(widget.borderRadius),
          border: widget.border ?? defaultBorder(widget.borderRadius),
          focusedBorder: widget.focusedBorder ?? defaultBorder(widget.borderRadius),
        ),
      ),
    );
  }

  InputBorder defaultBorder(double borderRadius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
    );
  }
}
