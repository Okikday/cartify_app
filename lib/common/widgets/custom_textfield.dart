import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String? hint;   //Shows hint
  final String? label;   //Shows Label
  final double pixelHeight;   //Use pixel height for the normal height, declare for pixel if you want more customization over size
  final double pixelWidth;   //.... width for the normal width
  final double? screenHeight;   //Use this for height with respect to the screen size
  final double? screenWidth; 
  final bool alwaysShowSuffixIcon;   //If you always want to show the password icon, if false, it only shows when Textfield has focus and has suffixIcon
  final String defaultText;    //Default text on the Textfield 
  final void Function()? ontap;   //Action when you tap the Textfield
  final Function(String text)? onchanged;   //Action if there's any change to Textfield content, also returns the text
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final bool obscureText;   //Whether to hide text
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final double borderRadius;
  final Color? backgroundColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextEditingController? controller;

  const CustomTextfield({
    super.key,
    this.hint,
    this.label,
    this.screenHeight,
    this.screenWidth,
    this.alwaysShowSuffixIcon = false,
    this.defaultText = "",
    this.ontap,
    this.onchanged,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.pixelHeight = 48,
    this.pixelWidth = 200,
    this.obscureText= false,
    this.hintStyle,
    this.labelStyle,
    this.inputTextStyle,
    this.borderRadius = 8,
    this.backgroundColor,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.controller,
  });

  @override
  State<CustomTextfield> createState() => _TextFieldState();
}

class _TextFieldState extends State<CustomTextfield> {
  final TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String? text;
  bool showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(refreshSuffixIconState);
     if(widget.alwaysShowSuffixIcon == true){
      
     }else{
      widget.controller == null ? textController.addListener(refreshSuffixIconState) : widget.controller!.addListener(refreshSuffixIconState);
     }
    widget.controller == null ? textController.text = widget.defaultText : widget.controller!.text = widget.defaultText;
    refreshSuffixIconState();
  }

  @override
  void dispose() {
    focusNode.removeListener(refreshSuffixIconState);
    widget.controller == null ? textController.removeListener(refreshSuffixIconState) : widget.controller!.removeListener(refreshSuffixIconState);
    focusNode.dispose();
    widget.controller == null ? textController.dispose() : widget.controller!.dispose();
    super.dispose();
  }
  

  void refreshSuffixIconState() {
    if(widget.alwaysShowSuffixIcon == true){
      showSuffixIcon = true;
    }else{
      if(widget.suffixIcon != null && focusNode.hasFocus){
        if(widget.controller == null ? textController.text.isNotEmpty : widget.controller!.text.isNotEmpty){
          setState(() => showSuffixIcon = true);
          
        }else{
          setState(() => showSuffixIcon = false);
        }
      }else{
        setState(() => showSuffixIcon = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.screenWidth != null ? DeviceUtils.getScreenWidth(context) * (widget.screenWidth! / 100) : widget.pixelWidth,
      height: widget.screenHeight != null ? DeviceUtils.getScreenHeight(context) * (widget.screenHeight! / 100) : widget.pixelHeight,
      child: TextField(
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        controller: widget.controller ?? textController,
        focusNode: focusNode,
        onChanged: (text) {
          setState(() {
            widget.controller == null ? textController.text = text : widget.controller!.text = text;
            if(text.isNotEmpty){
              refreshSuffixIconState();
            }
          });
         if(widget.onchanged != null){
          widget.onchanged!(text);
         }
        },
        onTap: (){
          refreshSuffixIconState();
          widget.ontap;
        },
        onTapOutside: (e){focusNode.unfocus(); widget.alwaysShowSuffixIcon != true ? refreshSuffixIconState() : (){};},
        style: widget.inputTextStyle ?? const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        cursorRadius: const Radius.circular(12),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: showSuffixIcon == true ? widget.suffixIcon : const SizedBox(),
          hintText: widget.hint,
          labelText: widget.label,
          labelStyle: widget.labelStyle ?? TextStyle(color: DeviceUtils.isDarkMode(context) == true ? Colors.white : Colors.black),
          hintStyle: widget.hintStyle ?? TextStyle(color: DeviceUtils.isDarkMode(context) == true ? Colors.white : Colors.black),
          filled: true,
          fillColor: widget.backgroundColor ?? Colors.transparent,
          contentPadding: const EdgeInsets.all(16),
          enabledBorder: widget.enabledBorder ?? defaultBorder(widget.borderRadius),
          border: widget.border ?? defaultBorder(widget.borderRadius),
          focusedBorder: widget.focusedBorder ?? defaultBorder(widget.borderRadius),
          
        ),
      ),
    );
  }

  InputBorder defaultBorder(double borderRadius){
    return OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          );
  }
}
