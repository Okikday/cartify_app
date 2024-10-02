import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/product_services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/utils/formatter.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/pages/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsFutureProvider = FutureProvider<List<ProductsModels>>((ref) async {
  final products = await productServices.getProducts();
  products.shuffle();
  return products;
});

class ProductForYou extends ConsumerWidget {
  final String topic;

  const ProductForYou({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
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
            height: 275,
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
                      category: product.category,
                      assetName: product.photo.first,
                      price: "N${Formatter.parsePrice(product.price, asInt: true)}",
                      rating: "4.8",
                      first: index == 0,
                      last: index == products.length - 1,
                      onClick: () {
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
                                updatedAt: product.updatedAt,));
                      },
                    );
                  },
                ),
              ),
              error: (error, stackTrace) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: ConstantWidgets.text(context, "Unable to connect!. Try connecting to a network", color: Colors.red)),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: LoadingShimmer(
                      width: screenWidth * 0.9,
                      height: 180,
                    ),
                  ),
                ],
              ),
              loading: () => LoadingShimmer(
                width: screenWidth * 0.9,
                height: 240,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class ProductForYouCard extends StatelessWidget {
  final String productName;
  final String category;
  final String assetName;
  final String price;
  final String rating;
  final bool? first;
  final bool? last;
  final void Function()? onClick;
  const ProductForYouCard(
      {super.key,
      required this.productName,
      required this.category,
      required this.assetName,
      required this.price,
      required this.rating,
      this.first = false,
      this.last = false,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = DeviceUtils.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(first == true ? 16 : 8, 8, last == true ? 16 : 8, 8),
      child: InkWell(
        onTap: () {
          onClick == null ? () {} : onClick!();
        },
        overlayColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold.withAlpha(50)),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 270,
          width: 164,
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: CartifyColors.royalBlue.withAlpha(75)),
            borderRadius: BorderRadius.circular(12),
            color: isDarkMode == true ? CartifyColors.lightPremiumGold.withAlpha(10) : CartifyColors.royalBlue.withOpacity(0.1),
            boxShadow: isDarkMode == true
                ? [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(2, 2), blurStyle: BlurStyle.inner),
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
                width: 146,
                height: 146,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: CartifyColors.royalBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CachedNetworkImage(
                  imageUrl: assetName,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const LoadingShimmer(
                    width: 140,
                    height: 140,
                  ),
                  errorWidget: (context, url, error) => const SizedBox(width: 140, height: 140, child: Center(child: Icon(Icons.error))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ConstantWidgets.text(context, productName, overflow: TextOverflow.clip, fontWeight: FontWeight.bold, fontSize: 11),
              const SizedBox(
                height: 2,
              ),
              ConstantWidgets.text(context, category, color: CartifyColors.battleshipGrey, overflow: TextOverflow.ellipsis, fonstStyle: FontStyle.italic, fontSize: 11),
              const SizedBox(
                height: 2,
              ),
              ConstantWidgets.text(context, price, color: Colors.green, fontWeight: FontWeight.bold),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: CartifyColors.premiumGold,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      ConstantWidgets.text(context, rating, fontWeight: FontWeight.bold, fontSize: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
