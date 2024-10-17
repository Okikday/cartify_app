import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/vendor_services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/pages/product_description.dart';
import 'package:cartify/views/pages/pages/update_product.dart';
import 'package:cartify/views/pages/pages/upload_product.dart';
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
                Expanded(child: ConstantWidgets.text(context, "Manage Products", fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
                ref.refresh(vendorProductsFutureProvider);
                DeviceUtils.showFlushBar(context, "Refreshing vendor products");
              },
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: CartifyColors.royalBlue.withAlpha(25),
                    child: Icon(
                      Icons.add_rounded,
                      size: 32,
                      color: CartifyColors.royalBlue.withAlpha(200),
                    ),
                  ),
                  title: ConstantWidgets.text(context, "Upload your Product", color: CartifyColors.royalBlue.withAlpha(200)),
                  onTap: () {if (context.mounted) DeviceUtils.pushMaterialPage(context, const UploadProduct());},
                ),
                Divider(
                   color: DeviceUtils.isDarkMode(context) ? CartifyColors.battleshipGrey : CartifyColors.lightGray,
                    ),
                Expanded(
                    child: vendorProductsAsyncValue.when(
                        data: (products) => products != null && products.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.only(top: 6, bottom: 24),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () => DeviceUtils.pushMaterialPage(context, ProductDescription(product: products[index])),
                                        title: ConstantWidgets.text(context, products[index].name, fontSize: 16, fontWeight: FontWeight.bold),
                                        subtitle: Text(products[index].category),
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: CartifyColors.royalBlue.withAlpha(40)),
                                          child: CachedNetworkImage(
                                            imageUrl: products[index].photo.first,
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
                                        trailing: IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            DeviceUtils.pushMaterialPage(context, UpdateProduct(productId: products[index].id));
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, right: 16),
                                        child: Divider(
                                          color: DeviceUtils.isDarkMode(context) ? CartifyColors.battleshipGrey : CartifyColors.lightGray,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: ConstantWidgets.text(context, "No Products found for current vendor!"),
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
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: LoadingShimmer(
                                    width: screenWidth * 0.9,
                                    height: 64,
                                  ),
                                ));
                              },
                            ))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
