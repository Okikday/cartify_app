import 'package:cartify/views/pages/elements/product_card.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ProductCard(),
    );
  }
}