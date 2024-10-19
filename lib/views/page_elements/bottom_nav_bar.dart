// ignore_for_file: prefer_const_constructors

import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;
  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: CartifyColors.premiumGold,
      unselectedItemColor: DeviceUtils.isDarkMode(context) == true ? CartifyColors.battleshipGrey : CartifyColors.richBlack,
      showUnselectedLabels: true,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      iconSize: 32,
      currentIndex: currentIndex,
      onTap: (index) => onTap(index),
      
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.person_home_16_regular,), label: "Home", tooltip: "Home tab",
          activeIcon: Icon(FluentIcons.person_home_16_filled)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined), label: "Categories", tooltip: "Categories tab",
          activeIcon: Icon(Icons.category),
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.cart_16_regular), label: "Carts", tooltip: "Carts tab",
          activeIcon: Icon(FluentIcons.cart_16_filled)
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.bookmark_16_regular), label: "Wishlists", tooltip: "Wishlist tab",
          activeIcon: Icon(FluentIcons.bookmark_16_filled)
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.settings_16_regular), label: "Account", tooltip: "Account tab",
          activeIcon: Icon(FluentIcons.settings_16_filled)
        ),
    ]);
  }
}