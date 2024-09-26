import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class ProductForYou extends StatelessWidget {
  final String topic;
  final List list;

  const ProductForYou({
    super.key,
    required this.topic,
    required this.list,
  });
  //ProductForYou name, description, assetName
 
  @override
  Widget build(BuildContext context) {
    double screenWidth = DeviceUtils.getScreenWidth(context);
    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ConstantWidgets.text(context, topic, fontSize: 16, fontWeight: FontWeight.w600)
                ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                  child: ConstantWidgets.text(context, "See all", color: CartifyColors.premiumGold)
                  
                  ),
            ],
          ),
          const SizedBox(height: 4,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < list.length; i++) 
                  ProductForYouCard(productName: list[i]["name"], description: list[i]["description"], assetName: list[i]["assetName"], price: list[i]["price"], first: i == 0 ? true : false, last: i == list.length-1 ? true : false,),
                ],
              ),
            ),
          const SizedBox(height: 12,)
        ],
      ),
    );
  }
}

class ProductForYouCard extends StatelessWidget {
  final String productName;
  final String description;
  final String assetName;
  final String price;
  final bool? first;
  final bool? last;
  const ProductForYouCard({
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
        padding: EdgeInsets.fromLTRB(first == true ? 12 : 8, 8, last == true ? 12 : 8, 8),
        child: InkWell(
          onTap: (){},
          overlayColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold.withAlpha(50)),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: CartifyColors.royalBlue.withAlpha(25)),
              borderRadius: BorderRadius.circular(12),
              color: DeviceUtils.isDarkMode(context) == true ? CartifyColors.lightPremiumGold.withAlpha(10) : CartifyColors.royalBlue.withOpacity(0.1),
              boxShadow: DeviceUtils.isDarkMode(context) == true ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: Offset(2, 2), blurStyle: BlurStyle.inner),]
               : [BoxShadow(color: CartifyColors.lightGray.withOpacity(0.5), blurRadius: 8, offset: Offset(0, 0), blurStyle: BlurStyle.inner, spreadRadius: 2),],
            ),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: CartifyColors.royalBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
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
              ConstantWidgets.text(context, price, color: Colors.green, fontWeight: FontWeight.bold),
            ],
          ),
              ),
        ),
      );
  }
}