import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/storage/product_data.dart';
import 'package:cartify/models/products_models.dart';
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
  List<ProductModel>? wishlists;
  @override
  void initState() {
    super.initState();
    loadWishlists();
  }

  loadWishlists() async{
    final List<ProductModel> getWishlists = await productData.getWishlists();
    setState(() {
      wishlists = getWishlists;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: wishlists == null || wishlists!.isEmpty ? 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.bookmark_outline_sharp, size: 64, color: CartifyColors.lightGray,),
                ConstantWidgets.text(context, "No wishlist added yet",),
              ],
            ) : 
            ListView.builder(
                itemCount: wishlists!.length,
                itemBuilder: (context, index) => Container(margin: const EdgeInsets.only(bottom: 12), child: WishlistCard(product: wishlists![index],)))),

      ],
    );
  }
}
