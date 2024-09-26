import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';

class HomeSpaceBarBg extends StatelessWidget {
  final String assetName;
  final String topic;
  final String description;
  final String imgSrc;

  const HomeSpaceBarBg({super.key, required this.assetName, required this.topic, required this.description, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcATop),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: imgSrc == "online" ? NetworkImage(assetName) : AssetImage(assetName),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstantWidgets.text(context, topic, fontSize: 28, fontWeight: FontWeight.bold, color: CartifyColors.antiFlashWhite),
              const SizedBox(
                height: 16,
              ),
              ConstantWidgets.text(context, description, color: Colors.white),
            ],
          ),
        )
      ],
    );
  }
}
