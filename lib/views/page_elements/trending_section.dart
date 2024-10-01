import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/utils/formatter.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/product_card_1.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:cartify/views/pages/pages/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class TrendingSection extends ConsumerWidget {
  const TrendingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsFutureProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return productsAsyncValue.when(
      data: (products) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            return ProductCard1(
              productName: product.name,
              assetName: product.photo.first,
              discountPercentage: product.discountPercentage,
              price: "N${Formatter.parsePrice(product.price, asInt: true)}",
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
                    price: "N${Formatter.parsePrice(product.price)}",
                    createdAt: product.createdAt,
                    updatedAt: product.updatedAt,
                  ),
                );
              },
            );
          },
          childCount: products.length,
        ),
      ),
      error: (error, stackTrace) {
        List<Widget> errorWidgets = [];
        for (int i = 0; i < 3; i++) {
          errorWidgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
              child: LoadingShimmer(
                shimmerDirection: ShimmerDirection.ttb,
                width: screenWidth,
                height: 180,
              ),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => errorWidgets[index],
            childCount: errorWidgets.length,
          ),
        );
      },
      loading: () {
        List<Widget> loadingWidgets = [];
        for (int i = 0; i < 3; i++) {
          loadingWidgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: LoadingShimmer(
                width: screenWidth,
                height: 180,
              ),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => loadingWidgets[index],
            childCount: loadingWidgets.length,
          ),
        );
      },
    );
  }
}


class TrendingSectionHeader extends ConsumerWidget {
  const TrendingSectionHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
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
    );
  }
}
