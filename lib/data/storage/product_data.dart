import 'package:cartify/app.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/utils/device_utils.dart';

final ProductData productData = ProductData();

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

  
  Future<List<String>> getWishlists() async => await hiveData.getData(key: "wishlistsData") ?? [];

  Future<void> addToWishlists(String wishlistID) async {
    final List<String> wishlists = await getWishlists();
    if(!wishlists.contains(wishlistID)){
      wishlists.add(wishlistID);
    }else{
      DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Product was already added");
    }
    await hiveData.setData(key: "wishlistsData", value: wishlists);
  }

  Future<void> removeFromWishlists(String id) async {
  final List<String> wishlists = await getWishlists();
  wishlists.removeWhere((product) => product == id);
  await hiveData.setData(key: "wishlistsData", value: wishlists);
}




}
