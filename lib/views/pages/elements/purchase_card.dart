import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseCard extends ConsumerStatefulWidget {
  final double screenWidth;
  const PurchaseCard({super.key, required this.screenWidth});

  @override
  ConsumerState<PurchaseCard> createState() => _PurchaseCardState();
}

class _PurchaseCardState extends ConsumerState<PurchaseCard> {
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(listener);
  }

  void listener(){
    print("focusnode listener run");
    if(focusNode.hasFocus == true){
      print("focusnode has focus");
      ref.read(simpleWidgetProvider).isOrdersBottomBarBuyNowVisible = false;
      
    }else{
      print("focusnode does not have focus");
      ref.read(simpleWidgetProvider).isOrdersBottomBarBuyNowVisible = true;
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(listener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
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
                      child: Image.asset("assets/images/iphone_15_pm.jpg"),
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
                          ConstantWidgets.text(context, "iPhone 15 pro Max", fontSize: 14, fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.cancel_sharp,
                                color: CartifyColors.lightGray,
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
                      ConstantWidgets.text(context, "Mobile phone", color: CartifyColors.royalBlue),
                      ConstantWidgets.text(context, "#1,700,000", color: CartifyColors.premiumGold),
                      Container(
                        child: ConstantWidgets.text(context, "Descriptions"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline_rounded)),
                          CustomTextfield(
                            focusNode: focusNode,
                            backgroundColor: const Color.fromARGB(26, 211, 211, 211),
                            contentPadding: EdgeInsets.all(2),
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
                        label: "Add to Cart",
                        borderRadius: 8,
                        textSize: 14,
                        side: BorderSide(width: 2, color: CartifyColors.aliceBlue.withAlpha(50)),
                        backgroundColor: CartifyColors.royalBlue,
                        onClick: () {
                          DeviceUtils.showFlushBar(context, "Say hi");
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
