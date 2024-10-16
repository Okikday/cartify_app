import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/vendor_services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/pages/product_description.dart';
import 'package:cartify/views/pages/pages/update_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendorProductsFutureProvider = FutureProvider<List<ProductModel>?>((ref) async {
  final products = await vendorServices.getVendorProducts();
  return products;
});

class ManageProductsView extends ConsumerStatefulWidget {
  const ManageProductsView({super.key});

  @override
  ConsumerState<ManageProductsView> createState() => _ManageProductsViewState();
}

class _ManageProductsViewState extends ConsumerState<ManageProductsView> {
  @override
  Widget build(BuildContext context) {
    final vendorProductsAsyncValue = ref.watch(vendorProductsFutureProvider);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight + 24,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const BackButton(),
                Expanded(child: ConstantWidgets.text(context, "Manage Products", fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Expanded(
            child: RefreshIndicator(
              onRefresh: () async{
            ref.refresh(vendorProductsFutureProvider);
            DeviceUtils.showFlushBar(context, "Refreshing vendor products");
          },
              child: vendorProductsAsyncValue.when(
                  data: (products) => ListView.builder(
                        padding: const EdgeInsets.only(top: 6, bottom: 24),
                        itemCount: products == null || products.isEmpty ? 0 : products.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => DeviceUtils.pushMaterialPage(context, ProductDescription(product: products[index])),
                            title: Text('Product ${products![index].name}'),
                            subtitle: Text(products[index].category),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                DeviceUtils.pushMaterialPage(context, UpdateProduct(productId: products[index].id));
                              },
                            ),
                          );
                        },
                      ),
                  error: (obj, error) => Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error,
                              size: 64,
                            ),
                            ConstantWidgets.text(context, "Unable to load vendor Products")
                          ],
                        ),
                      ),
                  loading: () => ListView.builder(
                        padding: const EdgeInsets.only(top: 6, bottom: 24),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Center(child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: LoadingShimmer(width: screenWidth * 0.9, height: 64,),
                          ));
                        },
                      )),
            )),
      ],
    );
  }
}
