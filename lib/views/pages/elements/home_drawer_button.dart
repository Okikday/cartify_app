import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';

class HomeDrawerButton extends StatelessWidget {
  const HomeDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: CartifyColors.lightGray,
      radius: 24,
      child: Icon(Icons.menu_rounded, color: CartifyColors.jetBlack,),
    );
  }
}