
import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final Function(String value)? onSelected;
  final void Function()? onopened;
  final void Function()? oncanceled;
  final List<String> menuItems;
  final Widget? icon;

  const CustomPopupMenuButton({
    super.key,
    this.onSelected,
    this.onopened,
    this.oncanceled,
    this.menuItems = const ["one", "two",],
    this.icon,
    });

  

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> popupMenuItems = 
  menuItems.map(
    (element){
      return PopupMenuItem<String>(
        value: element,
        child: Text(element),
        );
    }
  ).toList();

    return PopupMenuButton(
      tooltip: "Menu",
      color: Theme.of(context).scaffoldBackgroundColor,
      iconColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
      icon: icon,
      onSelected: (value) => onSelected!(value) ?? (){},
      onOpened: onopened,
      onCanceled: oncanceled,
      itemBuilder: (item){
       return popupMenuItems;
      },

      );
  }
}