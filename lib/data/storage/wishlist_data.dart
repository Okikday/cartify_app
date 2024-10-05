import 'package:cartify/data/hive_data/hive_data.dart';

class WishlistData {
  final HiveData hiveData = HiveData();
  getWishlists() async{
    final Map<String, dynamic> wishlistData = await hiveData.getData(key: "wishlistData");

  }
}