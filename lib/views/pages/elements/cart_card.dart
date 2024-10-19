import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/utils/formatter.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartCard extends ConsumerStatefulWidget {
  final double screenWidth;
  final Map product;
  final void Function() onCancelButtonClick;
  const CartCard({
    super.key, 
    required this.screenWidth,
    required this.product,
    required this.onCancelButtonClick,
    
  });

  @override
  ConsumerState<CartCard> createState() => _CartCardState();
}

class _CartCardState extends ConsumerState<CartCard> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(listener);
  }

  void listener() {
    if (focusNode.hasFocus == true) {
      ref.refresh(simpleWidgetProvider).isOrdersBottomBarBuyNowVisible = false;
    } else {
      ref.refresh(simpleWidgetProvider).isOrdersBottomBarBuyNowVisible = true;
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(listener);
    //focusNode is automatically disposed by CustomTextField
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    return CustomBox(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.screenWidth * 0.9, maxHeight: 400),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: widget.screenWidth * 0.35, maxHeight: 500),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                    imageUrl: widget.product['photo'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: LoadingShimmer(
                        width: 200,
                        height: 200,
                      ),
                    ),
                    errorWidget: (context, url, error) => SizedBox(width: widget.screenWidth * 0.35, height: widget.screenWidth, child: const Center(child: Icon(Icons.error))),
                  ),
                    )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: ConstantWidgets.text(context, widget.product['name'], fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 40,
                            height: 30,
                            child: IconButton(
                              onPressed: widget.onCancelButtonClick,
                              icon: Icon(
                                Icons.cancel_sharp,
                                color: isDarkMode ? CartifyColors.lightGray : Colors.white,
                                size: 28,
                              ),
                              padding: const EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ConstantWidgets.text(context, "category", color: CartifyColors.royalBlue),
                      
                      const SizedBox(
                        height: 8,
                      ),
                      ConstantWidgets.text(context, "Quantity:", color: CartifyColors.premiumGold),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline_rounded)),
                          CustomTextfield(
                            focusNode: focusNode,
                            isEnabled: false,
                            keyboardType: const TextInputType.numberWithOptions(),
                            backgroundColor: const Color.fromARGB(26, 211, 211, 211),
                            contentPadding: const EdgeInsets.all(2),
                            textAlign: TextAlign.center,
                            pixelWidth: 64,
                            pixelHeight: 32,
                            defaultText: "100",
                            inputTextStyle: const TextStyle(
                              color: CartifyColors.premiumGold,
                              fontSize: 10,
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline_rounded))
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomElevatedButton(
                        label: "Add to Orders",
                        borderRadius: 8,
                        textSize: 14,
                        side: BorderSide(width: 2, color: CartifyColors.aliceBlue.withAlpha(50)),
                        backgroundColor: CartifyColors.royalBlue,
                        onClick: () {
                          DeviceUtils.showFlushBar(context, "Can't add to Orders rn");
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
