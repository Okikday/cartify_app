import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 48,
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: CartifyColors.lightGray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2, color: CartifyColors.premiumGold),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, size: 28, color: CartifyColors.jetBlack,),
            const SizedBox(width: 8,),
            Expanded(child: ConstantWidgets.text(context, "Search something to purchase", fontWeight: FontWeight.bold, color: CartifyColors.jetBlack,))
          ],
        ),
      ),
    );
  }
}