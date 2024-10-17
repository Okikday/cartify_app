import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/vendor_services.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getVendorOrdersFutureProvider = FutureProvider<List<ProductModel>?>((ref) async {
  final products = await vendorServices.getVendorOrders();
  return products;
});

class OrderRequestsView extends ConsumerStatefulWidget {
  const OrderRequestsView({super.key});

  @override
  ConsumerState<OrderRequestsView> createState() => _OrderRequestsViewState();
}

class _OrderRequestsViewState extends ConsumerState<OrderRequestsView> {
  @override
  Widget build(BuildContext context) {
    final getVendorOrdersAsyncValue = ref.watch(getVendorOrdersFutureProvider);
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight + 24,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const BackButton(),
                Expanded(child: ConstantWidgets.text(context, "Order requests", fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Expanded(
          child: getVendorOrdersAsyncValue.when(
              data: (productOrders) => productOrders != null && productOrders.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.only(top: 6, bottom: 24),
                      itemCount: productOrders.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: CartifyColors.royalBlue.withAlpha(40)),
                            child: CachedNetworkImage(
                              imageUrl: productOrders[index].photo.first,
                              placeholder: (context, url) {
                                return const LoadingShimmer(
                                  width: 40,
                                  height: 40,
                                );
                              },
                              errorWidget: (context, url, error) => const Center(
                                  child: Icon(
                                Icons.error,
                                size: 36,
                              )),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: ConstantWidgets.text(context, productOrders[index].name, fontSize: 16, fontWeight: FontWeight.bold),
                          subtitle: Text(productOrders[index].price.toString()),
                          trailing: ElevatedButton(
                            child: const Text('Approve'),
                            onPressed: () {},
                          ),
                        );
                      },
                    )
                  : Center(
                      child: ConstantWidgets.text(context, "No Product has been Ordered yet!"),
                    ),
              error: (obj, error) => Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error,
                          size: 64,
                        ),
                        ConstantWidgets.text(context, "Unable to load vendor Products orders")
                      ],
                    ),
                  ),
              loading: () => ListView.builder(
                    padding: const EdgeInsets.only(top: 6, bottom: 24),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: LoadingShimmer(
                          width: screenWidth * 0.9,
                          height: 64,
                        ),
                      ));
                    },
                  )),
        )
      ],
    );
  }
}
