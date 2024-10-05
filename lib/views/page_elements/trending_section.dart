import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/states/layout_settings.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/utils/formatter.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/product_card_1.dart';
import 'package:cartify/views/pages/elements/product_card_2.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:cartify/views/pages/pages/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class TrendingSection extends ConsumerStatefulWidget {
  const TrendingSection({
    super.key,
  });

  @override
  ConsumerState<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends ConsumerState<TrendingSection> {
  late int gridType;

  @override
  void initState() {
    super.initState();
    loadLayoutSettings();
  }

  loadLayoutSettings() async{
    final int? settingGridType = await ref.read(layoutSettingProvider).getTrendingGridType();
    ref.read(layoutSettingProvider).trendingGridType = settingGridType ?? 1;
    setState(() => gridType = settingGridType ?? 1);
  }
  @override
  Widget build(BuildContext context) {
    gridType = ref.watch(layoutSettingProvider).trendingGridType;
    final productsAsyncValue = ref.watch(productsFutureProvider);
    final double screenWidth = MediaQuery.of(context).size.width;

    return productsAsyncValue.when(
      data: (products) => gridType == 1
          ? buildProductSliverList(products)
          : buildProductStaggeredGrid(context, products),
      error: (error, stackTrace) => buildErrorSliverList(screenWidth),
      loading: () => buildLoadingSliverList(screenWidth),
    );
  }

  // Build SliverList for product data
  Widget buildProductSliverList(List<ProductsModels> products) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return ProductCard1(
            productName: product.name,
            assetName: product.photo.first,
            discountPercentage: product.discountPercentage,
            price: "N ${Formatter.parsePrice(product.price, asInt: true)}",
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
    );
  }

  // Build StaggeredGrid for product data
  Widget buildProductStaggeredGrid(BuildContext context, List<ProductsModels> products) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            for (int i = 0; i < 2; i++)
              ProductCard2(
               productName: products[i].name,
            assetName: products[i].photo.first,
            discountPercentage: products[i].discountPercentage,
            price: "N ${Formatter.parsePrice(products[i].price, asInt: true)}",
            category: products[i].category,
            productID: products[i].id,
            onTap: (){
              DeviceUtils.pushMaterialPage(
                context,
                ProductDescription(
                  id: products[i].id,
                  vendor: products[i].vendor,
                  name: products[i].name,
                  photo: products[i].photo,
                  productDetails: products[i].productDetails,
                  category: products[i].category,
                  price: "N${Formatter.parsePrice(products[i].price)}",
                  createdAt: products[i].createdAt,
                  updatedAt: products[i].updatedAt,
                ),
              );
            },
              ),
          ],
        ),
      ),
    );
  }

  // Build SliverList for error state
  Widget buildErrorSliverList(double screenWidth) {
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
  }

  // Build StaggeredGrid for error state
  Widget buildErrorStaggeredGrid(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          for (int i = 0; i < 2; i++)
            LoadingShimmer(
              width: screenWidth * 0.45,
              height: 180,
            ),
        ],
      ),
    );
  }

  // Build SliverList for loading state
  Widget buildLoadingSliverList(double screenWidth) {
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
  }

  // Build StaggeredGrid for loading state
  Widget buildLoadingStaggeredGrid(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          for (int i = 0; i < 2; i++)
            LoadingShimmer(
              width: screenWidth * 0.45,
              height: 180,
            ),
        ],
      ),
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
          ConstantWidgets.text(context, "Trending", fontSize: 20, fontWeight: FontWeight.bold),
          IconButton(
            onPressed: () {
              final int gridType = ref.read(layoutSettingProvider).trendingGridType;

              if(gridType == 1){
                ref.refresh(layoutSettingProvider).trendingGridType = 2;
                ref.read(layoutSettingProvider).setTrendingGridType(2);
              }else{
                ref.refresh(layoutSettingProvider).trendingGridType = 1;
                ref.read(layoutSettingProvider).setTrendingGridType(1);
              }

              DeviceUtils.showFlushBar(context, "Changed Grid type");
            },
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
