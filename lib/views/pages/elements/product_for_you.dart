import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/product_services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/pages/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

final productsFutureProvider = FutureProvider<List<ProductsModels>>((ref) async {
  final productService = ProductServices();
  return await productService.getProducts(); // Fetch products using the function
});


class ProductForYou extends ConsumerWidget {
  final String topic;
  final List list;

  const ProductForYou({
    super.key,
    required this.topic,
    required this.list,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = DeviceUtils.getScreenWidth(context);
    final productsAsyncValue = ref.watch(productsFutureProvider);

    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ConstantWidgets.text(context, topic, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ConstantWidgets.text(context, "See all", color: CartifyColors.premiumGold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 270,
            child: productsAsyncValue.when(
              data: (products) => SizedBox(
                width: screenWidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductForYouCard(
                      productName: product.name,
                      description: product.category,
                      assetName: product.photo,
                      price: "\$${product.price}",
                      rating: "4.8",
                      first: index == 0,
                      last: index == list.length - 1,
                    );
                  },
                ),
              ),
              error: (error, stackTrace) => Center(
                child: SizedBox(
                  height: 200,
                  child: ConstantWidgets.text(context, "Unable to load products"),
                ),
              ),
              loading: () => _buildShimmerLoading(screenWidth),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Function to create a shimmer loading effect
  Widget _buildShimmerLoading(double screenWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5, // Show 5 shimmer placeholders
          itemBuilder: (context, index) {
            return Container(
              width: 150,
              height: 240,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.white, ),
              
            );
          },
        ),
      ),
    );
  }
}


class ProductForYouCard extends StatelessWidget {
  final String productName;
  final String description;
  final String assetName;
  final String price;
  final String rating;
  final bool? first;
  final bool? last;
  const ProductForYouCard({
    super.key,
    required this.productName,
    required this.description,
    required this.assetName,
    required this.price,
    required this.rating,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = DeviceUtils.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(first == true ? 16 : 8, 8, last == true ? 16 : 8, 8),
      child: InkWell(
        onTap: () {
          DeviceUtils.pushMaterialPage(context, const ProductDescription());
        },
        overlayColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold.withAlpha(50)),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 270,
          width: 156,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: CartifyColors.royalBlue.withAlpha(25)),
            borderRadius: BorderRadius.circular(12),
            color: isDarkMode == true ? CartifyColors.lightPremiumGold.withAlpha(10) : CartifyColors.royalBlue.withOpacity(0.1),
            boxShadow: isDarkMode == true
                ? [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: Offset(2, 2), blurStyle: BlurStyle.inner),
                  ]
                : [
                    BoxShadow(
                        color: CartifyColors.lightGray.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                        blurStyle: BlurStyle.inner,
                        spreadRadius: 2),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: CartifyColors.royalBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(assetName),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstantWidgets.text(context, productName)
                  //Text(rating.toString()),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              ConstantWidgets.text(context, description, color: CartifyColors.battleshipGrey, overflow: TextOverflow.ellipsis),
              const SizedBox(
                height: 8,
              ),
              ConstantWidgets.text(context, price, color: Colors.green, fontWeight: FontWeight.bold),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Icon(Icons.star_rounded, color: CartifyColors.premiumGold, size: 18,),
                const SizedBox(width: 4,),
                ConstantWidgets.text(context, rating, fontWeight: FontWeight.bold),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}



