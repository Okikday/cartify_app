import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/models/products_models.dart';

class ProductData {
  final HiveData hiveData = HiveData();

  static const List<String> categories = [
    "--",
    "Electronics & Gadgets",
    "Fashion & Apparel",
    "Health & Beauty",
    "Home & Kitchen",
    "Sports & Outdoors",
    "Toys & Games",
    "Books & Stationery",
  ];

  
  Future<List<ProductModel>> getWishlists() async => await hiveData.getData(key: "wishlistsData") ?? [];

  Future<void> addToWishlists(ProductModel wishlist) async {
    final List<ProductModel> wishlists = await getWishlists();
    wishlists.add(wishlist);
    await hiveData.setData(key: "wishlistsData", value: wishlists);
  }

  Future<void> removeFromWishlists(String id) async {
  final List<ProductModel> wishlists = await getWishlists();
  wishlists.removeWhere((product) => product.id == id);
  await hiveData.setData(key: "wishlistsData", value: wishlists);
}




}
