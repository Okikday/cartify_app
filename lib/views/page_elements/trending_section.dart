import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/product_card_1.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:cartify/views/pages/pages/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrendingSection extends ConsumerWidget {
  const TrendingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final gridType = LayoutSettings().getTrendingGridType();
    final productsAsyncValue = ref.watch(productsFutureProvider);
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstantWidgets.text(context, "Trending", fontSize: 20),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.grid_view_rounded,
                  color: Colors.black,
                ),
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold)),
              ),
            ],
          ),
        ),
        productsAsyncValue.when(
            data: (products) => ListView.builder(
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard1(
                      assetName: product.photo,
                      price: product.price.toString(),
                      category: product.category,
                      productID: product.id,
                      onTap: () {
                        DeviceUtils.pushMaterialPage(
                            context,
                            ProductDescription(
                                id: product.id,
                                vendor: product.vendor,
                                name: product.name,
                                photo: product.photo,
                                productDetails: product.productDetails,
                                category: product.category,
                                price: product.price,
                                createdAt: product.createdAt,
                                updatedAt: product.updatedAt,
                                ));
                      },
                    );
                  },
                ),
            error: (error, stackTrace) => ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: LoadingShimmer(
                        width: screenWidth,
                        height: 180,
                        child: ConstantWidgets.text(context, "Unable to conect!", fontSize: 16),
                      ),
                    )),
            loading: () => ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: LoadingShimmer(
                        width: screenWidth,
                        height: 180,
                      ),
                    ))),
      ],
    );
  }
}
