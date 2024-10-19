import 'package:cartify/app.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/data/storage/orders_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/cart_services.dart';
import 'package:cartify/services/product_services.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final cartsProductsFutureProvider = FutureProvider<List<ProductModel>>((ref) async {
//   final OrdersData ordersData = OrdersData();
//   List<ProductModel> tempCarts = [];
//   try {
//     List<String> getCarts = await ordersData.getCarts();
//     for (String id in getCarts) {
//       final product = await productServices.getProductByID(id: id);
//       if (product is ProductModel) {
//         tempCarts.add(product);
//       }
//     }
//   } catch (e) {
//     // ignore: avoid_print
//     print("Error loading Carts: $e");
//     tempCarts = [];
//   }
//   return tempCarts;
// });

final getCartsFutureProvider = FutureProvider<List?>((ref) async {
  final List? products = await CartServices().getUserCarts();
  return products;
});

class Orders extends ConsumerStatefulWidget {
  const Orders({
    super.key,
  });

  static bool showBottomBuyBanner = false;

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: unused_result
      ref.refresh(getCartsFutureProvider);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    final getCartsAsyncValue = ref.watch(getCartsFutureProvider);

    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          TabBar(
              controller: tabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              splashFactory: NoSplash.splashFactory,
              onTap: (index) {},
              tabs: const [
                Tab(
                  text: "Carts",
                  icon: Icon(Icons.shopping_cart),
                ),
                Tab(text: "Orders", icon: Icon(Icons.shopping_cart_checkout_rounded))
              ]),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              RefreshIndicator(
                onRefresh: () async {
                  // ignore: unused_result
                  ref.refresh(getCartsFutureProvider);
                },
                child: getCartsAsyncValue.when(
                  data: (products) {
                    print(products.toString());
                    return products == null || products.isEmpty
                        ? Center(
                            child: ConstantWidgets.text(context, "You haven't added any product to cart"),
                          )
                        : ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.only(bottom: 0),
                                child: CartCard(
                                  screenWidth: screenWidth,
                                  product: products[index],
                                  onCancelButtonClick: () async {
                                    final String? outcome = await CartServices().removeProductFromCarts(productId: products[index]['productId']);
                                    if(outcome == null){
                                      ref.refresh(getCartsFutureProvider);
                                    DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Removed Product from Carts");
                                    }else{
                                    DeviceUtils.showFlushBar(globalNavKey.currentContext!, outcome.toString());
                                    }
                                  },
                                )));
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => const Center(child: Text("Error loading Carts products")),
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {},
                child: Stack(
                  children: [
                    Center(
                      child: ConstantWidgets.text(context, "Order are not available"),
                    ),
                    BottomBarBuyNow(isDarkMode: isDarkMode, screenWidth: screenWidth)
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class BottomBarBuyNow extends ConsumerWidget {
  const BottomBarBuyNow({
    super.key,
    required this.isDarkMode,
    required this.screenWidth,
  });

  final bool isDarkMode;
  final double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: ref.watch(simpleWidgetProvider).isOrdersBottomBarBuyNowVisible,
      maintainSize: false,
      child: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          width: 200,
          height: 72,
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: isDarkMode == true
                  ? [
                      BoxShadow(color: CartifyColors.richBlack.withAlpha(75), offset: const Offset(-2, -2), blurRadius: 4),
                      BoxShadow(
                        color: CartifyColors.royalBlue.withAlpha(50),
                        offset: const Offset(2, 2),
                      )
                    ]
                  : [
                      BoxShadow(color: CartifyColors.richBlack.withAlpha(75), offset: const Offset(2, 2), blurRadius: 4),
                      BoxShadow(
                        color: CartifyColors.royalBlue.withAlpha(25),
                        offset: const Offset(-2, -2),
                      )
                    ]),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  ConstantWidgets.text(context, "Total Price:", fontSize: 16, fontWeight: FontWeight.bold),
                  ConstantWidgets.text(context, "N 0", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)
                ],
              )),
              CustomElevatedButton(
                pixelWidth: screenWidth * 0.25,
                pixelHeight: 36,
                borderRadius: 8,
                elevation: 8,
                backgroundColor: isDarkMode == true ? CartifyColors.lightGray : CartifyColors.jetBlack,
                onClick: () {
                  DeviceUtils.showFlushBar(context, "Processing...");
                },
                child: Center(
                  child: ConstantWidgets.text(context, "Buy now", invertColor: true, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
