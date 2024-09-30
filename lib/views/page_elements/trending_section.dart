import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/product_card_1.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrendingSection extends ConsumerWidget {
  final int gridType;
  const TrendingSection({super.key, required this.gridType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsFutureProvider);
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return productsAsyncValue.when(
        data: (products) => ListView.builder(
              itemBuilder: (context, index) => ProductCard1(
                  assetName: products[index].photo, 
                  price: products[index].price.toString(), 
                  category: products[index].category, 
                  productID: products[index].id),
            ),
        error: (error, stackTrace) => ListView.builder(
              itemBuilder: (context, index) => const ProductCard1(
                  assetName: "assets/images/iphone_15_pm.jpg", 
                  price: "1700000", 
                  category: "Mobile phone", 
                  productID: "products[index].id"
                  ),
            ),
        loading: () => ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: LoadingShimmer(
                    width: screenWidth,
                    height: 180,
                  ),
                )));
  }
}
