import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class ProductCategories extends StatelessWidget {
  final String topic;
  final List list;

  const ProductCategories({
    super.key,
    required this.topic,
    required this.list,
  });
  //ProductCategories name, description, assetName
 
  @override
  Widget build(BuildContext context) {
    double screenWidth = DeviceUtils.getScreenWidth(context);
    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: ConstantWidgets.text(context, topic, fontSize: 20)
                ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                  child: ConstantWidgets.text(context, "See all")
                  
                  ),
            ],
          ),
          const SizedBox(height: 8,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < list.length; i++) 
                  ProductCategoriesBox(productName: list[i]["name"], description: list[i]["description"], assetName: list[i]["assetName"], price: list[i]["price"], first: i == 0 ? true : false, last: i == list.length-1 ? true : false,),
                ],
              ),
            ),
          const SizedBox(height: 12,)
        ],
      ),
    );
  }
}

class ProductCategoriesBox extends StatelessWidget {
  final String productName;
  final String description;
  final String assetName;
  final String price;
  final bool? first;
  final bool? last;
  const ProductCategoriesBox({
    super.key,
    required this.productName,
    required this.description,
    required this.assetName,
    required this.price,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.fromLTRB(first == true ? 8 : 8, 8, last == true ? 12 : 8, 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 121, 111, 76).withAlpha(75),
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(assetName),
                ),
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstantWidgets.text(context, productName)
                //Text(rating.toString()),
              ],
            ),
            const SizedBox(height: 4,),
            ConstantWidgets.text(context, description, color: CartifyColors.battleshipGrey),
            const SizedBox(height: 8,),
            ConstantWidgets.text(context, price, color: Colors.greenAccent, fontWeight: FontWeight.bold),
          ],
        ),
            ),
      );
  }
}