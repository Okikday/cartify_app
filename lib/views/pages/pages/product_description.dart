import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/test_data.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDescription extends ConsumerStatefulWidget {
  final String id;
  final String vendor;
  final String name;
  final String photo;
  final String productDetails;
  final String category;
  final double price;
  final int units;
  final double discountPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> averageRating;
  final double? discountedPrice;
  const ProductDescription({
    super.key,
    required this.id,
    required this.vendor,
    required this.name,
    required this.photo,
    required this.productDetails,
    required this.category,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.averageRating = const {},
    this.units = 1,
    this.discountPercentage = 0,
    this.discountedPrice,
  });

  @override
  ConsumerState<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends ConsumerState<ProductDescription> with SingleTickerProviderStateMixin {
  late TabController imageTabController;

  @override
  void initState() {
    super.initState();
    imageTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    imageTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = DeviceUtils.getScreenHeight(context);

    return Scaffold(
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
                                children: [
                                  ImageTab(assetName: widget.photo,),
                                  ImageTab(assetName: widget.photo,),
                                  ImageTab(assetName: widget.photo,),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(24), color: CartifyColors.royalBlue.withAlpha(75), boxShadow: [
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
            body: ProductDescBody(productName: widget.name, price: widget.price.toString(), description: widget.productDetails),
            ));
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
        padding: EdgeInsets.only(left: 16, right: 16, top: kToolbarHeight-28),
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
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 4),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ProductDescBody extends StatelessWidget {
  final String productName;
  final String price;
  final String description;
  const ProductDescBody({
    super.key,
    required this.productName,
    required this.price,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
          Divider(color: CartifyColors.premiumGold.withAlpha(50), thickness: 4,),
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
                child: ConstantWidgets.text(
                    context,
                    description),
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
                          SizedBox(width: 125, child: ConstantWidgets.text(context, "Storage:")),
                          ConstantWidgets.text(context, "256GB"),
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ReviewBox(),
              const SizedBox(
                height: 24,
              ),
              ProductForYou(topic: "Similar items", list: TestData.productCategoriesList)
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
    final double screenWidth = DeviceUtils.getScreenWidth(context);
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
                        ConstantWidgets.text(context, "Excellent",),
                        SizedBox(
                            width: screenWidth * 0.4,
                            child: LinearProgressIndicator(color: CartifyColors.royalBlue,backgroundColor: CartifyColors.premiumGold.withAlpha(100),borderRadius: BorderRadius.circular(12),
                              value: 0.9,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstantWidgets.text(context, "Very Good"),
                        SizedBox(width: screenWidth * 0.4, child: LinearProgressIndicator(color: CartifyColors.royalBlue,backgroundColor: CartifyColors.premiumGold.withAlpha(100),borderRadius: BorderRadius.circular(12), value: 0.8))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ConstantWidgets.text(context, "Average"), SizedBox(width: screenWidth * 0.4, child: LinearProgressIndicator(color: CartifyColors.royalBlue,backgroundColor: CartifyColors.premiumGold.withAlpha(100),borderRadius: BorderRadius.circular(12), value: 0.7))],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ConstantWidgets.text(context, "Poor"), SizedBox(width: screenWidth * 0.4, child: LinearProgressIndicator(color: CartifyColors.royalBlue,backgroundColor: CartifyColors.premiumGold.withAlpha(100),borderRadius: BorderRadius.circular(12), value: 0.6))],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstantWidgets.text(context, "Very Poor"),
                        SizedBox(width: screenWidth * 0.4, child: LinearProgressIndicator(color: CartifyColors.royalBlue,backgroundColor: CartifyColors.premiumGold.withAlpha(100),borderRadius: BorderRadius.circular(12), value: 0.5))
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

class ImageTab extends StatelessWidget {
  final String assetName;
  const ImageTab({
    super.key,
    required this.assetName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 92, right: 1),
      decoration: BoxDecoration(
        color: CartifyColors.royalBlue.withAlpha(25),
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.colorBurn),
        child: Image.network( assetName, fit: BoxFit.cover,),
      ),
    );
  }
}
