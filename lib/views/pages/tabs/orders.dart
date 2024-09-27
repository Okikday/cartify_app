import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/purchase_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key,});

  static bool showBottomBuyBanner = false;

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> with WidgetsBindingObserver{

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConstantWidgets.text(
              context,
              "Purchase",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
            child: Stack(
          children: [
            ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: PurchaseCard(
                      screenWidth: screenWidth,
                    ))),
            BottomBarBuyNow(isDarkMode: isDarkMode, screenWidth: screenWidth,)
          ],
        ))
      ],
    );
  }
}

class BottomBarBuyNow extends ConsumerWidget {

  const BottomBarBuyNow({
    super.key,
    required this.isDarkMode,
    required this.screenWidth,
  });

  final bool isDarkMode;
  final double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Visibility(
      visible: ref.watch(simpleWidgetProvider).isOrdersBottomBarBuyNowVisible,
      maintainSize: false,
      child: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          width: 200,
          height: 64,
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: isDarkMode == true
                  ? [
                      BoxShadow(color: CartifyColors.richBlack.withAlpha(75), offset: const Offset(-2, -2), blurRadius: 4),
                      BoxShadow(
                        color: CartifyColors.royalBlue.withAlpha(50),
                        offset: const Offset(2, 2),
                      )
                    ]
                  : [
                      BoxShadow(color: CartifyColors.richBlack.withAlpha(75), offset: const Offset(2, 2), blurRadius: 4),
                      BoxShadow(
                        color: CartifyColors.royalBlue.withAlpha(25),
                        offset: const Offset(-2, -2),
                      )
                    ]),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  ConstantWidgets.text(context, "Total Price:", fontSize: 16, fontWeight: FontWeight.bold),
                  ConstantWidgets.text(context, " \$1200", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)
                ],
              )),
              CustomElevatedButton(
                pixelWidth: screenWidth * 0.25,
                pixelHeight: 36,
                borderRadius: 8,
                elevation: 8,
                backgroundColor: isDarkMode == true ? CartifyColors.lightGray : CartifyColors.jetBlack,
                onClick: () {
                  DeviceUtils.showFlushBar(context, "Say hi");
                },
                child: Center(
                  child: ConstantWidgets.text(context, "Buy now", invertColor: true, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




