import 'package:cartify/app.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/utils/device_utils.dart';

class OrdersData {
  final HiveData hiveData = HiveData();

  Future<List<String>> getCarts() async => await hiveData.getData(key: "cartsData") ?? [];

  Future<void> addTocarts(String cartID) async {
    final List<String> carts = await getCarts();
    if (!carts.contains(cartID)) {
      carts.add(cartID);
    } else {
      DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Product was already added");
    }
    await hiveData.setData(key: "cartsData", value: carts);
  }

  Future<void> removeFromcarts(String id) async {
    final List<String> carts = await getCarts();
    carts.removeWhere((product) => product == id);
    await hiveData.setData(key: "cartsData", value: carts);
  }
}
