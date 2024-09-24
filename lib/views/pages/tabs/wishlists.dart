import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/views/pages/elements/wishlist_card.dart';
import 'package:flutter/material.dart';

class Wishlists extends StatelessWidget {
  const Wishlists({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConstantWidgets.text(
              context,
              "Wishlists",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8,),

        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView.builder(itemCount: 10, itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: const WishlistCard())),
        ))
      ],
    );
  }
}