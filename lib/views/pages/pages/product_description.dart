import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/storage/product_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/utils/formatter.dart';
import 'package:cartify/views/pages/elements/custom_overlay.dart';
import 'package:cartify/views/pages/elements/image_interactive_view.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:cartify/views/pages/tabs/wishlists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDescription extends ConsumerStatefulWidget {
  final ProductModel product;
  const ProductDescription({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends ConsumerState<ProductDescription> with SingleTickerProviderStateMixin {
  late TabController imageTabController;

  @override
  void initState() {
    super.initState();
    imageTabController = TabController(length: widget.product.photo.length, vsync: this);
  }

  @override
  void dispose() {
    imageTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: ref.watch(simpleWidgetProvider).isProductInfoImageTabVisible == false,
      onPopInvokedWithResult: (didPop, result) {
        if(ref.watch(simpleWidgetProvider).isProductInfoImageTabVisible == true){
          ref.read(simpleWidgetProvider).reverseImageInteractiveAnimController(context);
        }
      },
      child: Scaffold(
      
          body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.white.withOpacity(0.01),
            collapsedHeight: 96,
            expandedHeight: screenHeight * 0.5,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  expandedTitleScale: 1.005,
                  collapseMode: CollapseMode.parallax,
                  title: const DescriptionTitle(),
                  background: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      TabBarView(
                        controller: imageTabController,
                        children: [for (int i = 0; i < widget.product.photo.length; i++) ImageTab(assetName: widget.product.photo[i])],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: CartifyColors.royalBlue.withAlpha(75), boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.5), blurStyle: BlurStyle.outer),
                            ]),
                            child: TabPageSelector(
                              selectedColor: Colors.white,
                              controller: imageTabController,
                            )),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
        body: ProductDescBody(id: widget.product.id, productName: widget.product.name, price: "N${Formatter.parsePrice(widget.product.price,)}", description: widget.product.productDetails),
      )),
    );
  }
}

class DescriptionTitle extends StatelessWidget {
  const DescriptionTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 96,
        padding: const EdgeInsets.only(left: 16, right: 16, top: kToolbarHeight - 28),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              style: ButtonStyle(
                  shadowColor: const WidgetStatePropertyAll(Colors.black), backgroundColor: WidgetStatePropertyAll(CartifyColors.royalBlue.withAlpha(50))),
            ),
            Align(
              alignment: Alignment.center,
              child: ConstantWidgets.text(
                context,
                "Product info",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                align: TextAlign.center,
                shadows: DeviceUtils.isDarkMode(context) == true
                    ? [
                        const Shadow(color: Colors.black, blurRadius: 4),
                      ]
                    : [
                        const Shadow(color: Colors.white, blurRadius: 4),
                      ],
              ),
            ),
            IconButton(
                style: ButtonStyle(
                    shadowColor: const WidgetStatePropertyAll(Colors.black), backgroundColor: WidgetStatePropertyAll(CartifyColors.royalBlue.withAlpha(50))),
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                ))
          ],
        ),
      ),
    );
  }
}

class ProductDescBody extends ConsumerWidget {
  final String id;
  final String productName;
  final String price;
  final String description;
  const ProductDescBody({super.key, required this.id, required this.productName, required this.price, required this.description});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstantWidgets.text(context, productName, fontSize: 16, fontWeight: FontWeight.bold),
                IconButton(
                  onPressed: () async{
                    final ProductData productData = ProductData();
                    await productData.addToWishlists(id);
                    ref.refresh(wishlistProductFutureProvider); // Refresh data after removal
                    if(context.mounted) DeviceUtils.showFlushBar(context, "Added product to Wishlists");
                  },
                  icon: const Icon(Icons.bookmark_add_outlined),
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.royalBlue.withAlpha(50))),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstantWidgets.text(context, price, color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                ConstantWidgets.text(context, "Rate Product",
                    textDecoration: TextDecoration.underline, color: CartifyColors.premiumGold, decorationColor: CartifyColors.premiumGold)
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Divider(
            color: CartifyColors.premiumGold.withAlpha(50),
            thickness: 4,
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ConstantWidgets.text(context, "Description", fontSize: 15, fontWeight: FontWeight.bold, color: CartifyColors.premiumGold),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ConstantWidgets.text(context, description),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    for (int i = 0; i < 4; i++)
                      Row(
                        children: [
                          SizedBox(width: 125, child: ConstantWidgets.text(context, "property:", color: CartifyColors.lightGray)),
                          ConstantWidgets.text(context, "value", color: CartifyColors.lightGray),
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const ReviewBox(),
              const SizedBox(
                height: 24,
              ),
              const ProductForYou(
                topic: "Similar items",
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ReviewBox extends StatelessWidget {
  const ReviewBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: CartifyColors.royalBlue.withAlpha(50),
      padding: const EdgeInsets.all(16),
      height: 180,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstantWidgets.text(context, "Reviews", fontWeight: FontWeight.bold, fontSize: 14),
              ConstantWidgets.text(context, "256 reviews", fontSize: 14, color: CartifyColors.premiumGold)
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: CartifyColors.premiumGold.withAlpha(125), borderRadius: BorderRadius.circular(16)),
                child: ConstantWidgets.text(context, "4.8", fontWeight: FontWeight.bold, fontSize: 32),
              ),
              SizedBox(
                width: screenWidth * 0.6,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstantWidgets.text(
                          context,
                          "Excellent",
                        ),
                        SizedBox(
                            width: screenWidth * 0.4,
                            child: LinearProgressIndicator(
                              color: CartifyColors.royalBlue,
                              backgroundColor: CartifyColors.premiumGold.withAlpha(100),
                              borderRadius: BorderRadius.circular(12),
                              value: 0.9,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstantWidgets.text(context, "Very Good"),
                        SizedBox(
                            width: screenWidth * 0.4,
                            child: LinearProgressIndicator(
                                color: CartifyColors.royalBlue,
                                backgroundColor: CartifyColors.premiumGold.withAlpha(100),
                                borderRadius: BorderRadius.circular(12),
                                value: 0.8))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstantWidgets.text(context, "Average"),
                        SizedBox(
                            width: screenWidth * 0.4,
                            child: LinearProgressIndicator(
                                color: CartifyColors.royalBlue,
                                backgroundColor: CartifyColors.premiumGold.withAlpha(100),
                                borderRadius: BorderRadius.circular(12),
                                value: 0.7))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstantWidgets.text(context, "Poor"),
                        SizedBox(
                            width: screenWidth * 0.4,
                            child: LinearProgressIndicator(
                                color: CartifyColors.royalBlue,
                                backgroundColor: CartifyColors.premiumGold.withAlpha(100),
                                borderRadius: BorderRadius.circular(12),
                                value: 0.6))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstantWidgets.text(context, "Very Poor"),
                        SizedBox(
                            width: screenWidth * 0.4,
                            child: LinearProgressIndicator(
                                color: CartifyColors.royalBlue,
                                backgroundColor: CartifyColors.premiumGold.withAlpha(100),
                                borderRadius: BorderRadius.circular(12),
                                value: 0.5))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ImageTab extends ConsumerWidget {
  final String assetName;
  const ImageTab({
    super.key,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.refresh(simpleWidgetProvider).isProductInfoImageTabVisible = true;
        CustomOverlay(context).showOverlay(
            child: ImageInteractiveView(
          assetName: assetName,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 92, right: 1),
        decoration: BoxDecoration(
          color: CartifyColors.royalBlue.withAlpha(25),
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.colorBurn),
          child: CachedNetworkImage(
            imageUrl: assetName,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircleAvatar(backgroundColor: Colors.transparent, child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
