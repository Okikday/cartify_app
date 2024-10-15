import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/storage/product_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/product_services.dart';
import 'package:cartify/views/pages/elements/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wishlists extends ConsumerStatefulWidget {
  const Wishlists({super.key});

  @override
  ConsumerState<Wishlists> createState() => _WishlistsState();
}

class _WishlistsState extends ConsumerState<Wishlists> {
  final ProductData productData = ProductData();
  List<String> getWishlists = [];
  List<ProductModel> wishlists = [];

  @override
  void initState() {
    super.initState();
    loadWishlists();
  }

  loadWishlists() async {
    getWishlists = await productData.getWishlists();
    wishlists = [];

    for (int i = 0; i < getWishlists.length; i++) {
      final dynamic product = await productServices.getProductByID(id: getWishlists[i]);
      if (product is ProductModel) {
        wishlists[i] = product;
        setState(() => wishlists);
      }else{
        break;
      }
    }

    //setState(() => wishlists);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 20,
      onRefresh: () async{
        getWishlists = await productData.getWishlists();
        if(getWishlists.length == wishlists.length){

        }else{
          loadWishlists();
        }
        
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
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: wishlists.isEmpty
                  ? Column(
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
                    )
                  : ListView.builder(
                      itemCount: wishlists.length,
                      itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: WishlistCard(
                            product: wishlists[index],
                          )))),
        ],
      ),
    );
  }
}
