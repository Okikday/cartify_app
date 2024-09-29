import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String? hintText;
  final List<String> dropdownEntryItems;
  final Function(String value)? onselected;
  final Widget? menuLabel;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final TextStyle? textStyle;
  const CustomDropdownMenu({
    super.key,
    this.hintText = "Dropdown",
    this.dropdownEntryItems = const ["one", "two"],
    this.onselected,
    this.menuLabel,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {

    List<DropdownMenuEntry> dropdownEntries = dropdownEntryItems.map(
        (element){
          return DropdownMenuEntry(value: element, label: element);
        }
      ).toList();

    return DropdownMenu(
      onSelected: (value) => onselected == null ? (){} : onselected!(value),
      hintText: hintText,
      label: menuLabel,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      width: width,
      dropdownMenuEntries: dropdownEntries,
      textStyle: textStyle,
      );
  }
}