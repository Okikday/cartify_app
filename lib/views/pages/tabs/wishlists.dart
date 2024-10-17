import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/storage/product_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/product_services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistProductFutureProvider = FutureProvider<List<ProductModel>>((ref) async {
  final ProductData productData = ProductData();
  List<ProductModel> tempWishlist = [];
  try {
    List<String> getWishlists = await productData.getWishlists();
    for (String id in getWishlists) {
      final product = await productServices.getProductByID(id: id);
      if (product is ProductModel) {
        tempWishlist.add(product);
      }
    }
  } catch (e) {
    print("Error loading wishlists: $e");
    tempWishlist = [];
  }
  return tempWishlist;
});

class Wishlists extends ConsumerStatefulWidget {
  const Wishlists({super.key});

  @override
  ConsumerState<Wishlists> createState() => _WishlistsState();
}

class _WishlistsState extends ConsumerState<Wishlists> {
  final ProductData productData = ProductData();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.refresh(wishlistProductFutureProvider);
      DeviceUtils.showFlushBar(context, "Checking for wishlists updates");
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishlistAsyncValue = ref.watch(wishlistProductFutureProvider);

    return RefreshIndicator(
      displacement: 20,
      onRefresh: () async {
        ref.refresh(wishlistProductFutureProvider);
        DeviceUtils.showFlushBar(context, "Refreshed Wishlists");
      },
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstantWidgets.text(
                context,
                "Wishlists",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: wishlistAsyncValue.when(
              data: (wishlists) {
                if (wishlists.isEmpty) {
                  return _buildEmptyWishlist(context);
                } else {
                  return ListView.builder(
                    itemCount: wishlists.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: WishlistCard(
                        product: wishlists[index],
                        onRemove: () {
                          productData.removeFromWishlists(wishlists[index].id);
                          ref.refresh(wishlistProductFutureProvider);
                          DeviceUtils.showFlushBar(context, "Removing product from Wishlist");
                        },
                      ),
                    ),
                  );
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => const Center(child: Text("Error loading wishlist")),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWishlist(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.bookmark_outline_sharp,
          size: 64,
          color: CartifyColors.lightGray,
        ),
        ConstantWidgets.text(
          context,
          "No wishlist added yet",
        ),
      ],
    );
  }
}
