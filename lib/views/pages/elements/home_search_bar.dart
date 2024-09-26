import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleWidgetProvider = ChangeNotifierProvider<SimpleWidgetStates>((ref) => SimpleWidgetStates());

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({
    super.key,
    required this.scrollContext,
    required this.bottomSheetAnimController,
  });

  final BuildContext scrollContext;
  final AnimationController bottomSheetAnimController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    final Color color = isDarkMode == true ? CartifyColors.lightGray : CartifyColors.onyxBlack;
    ref.watch(simpleWidgetProvider).homeSearchBarContext = context;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [
          BoxShadow(color: CartifyColors.premiumGold.withAlpha(75), blurRadius: 4, blurStyle: BlurStyle.inner),
          const BoxShadow(
            color: Colors.black54,
            blurRadius: 2,
            offset: Offset(1, 1),
            blurStyle: BlurStyle.outer,
          )
        ]),
        child: CustomTextfield(
          backgroundColor: CartifyColors.lightGray.withAlpha(50),
          prefixIcon: Icon(
            Icons.search,
            color: color,
          ),
          hint: "Search a product",
          hintStyle: TextStyle(color: color, fontSize: 14),
          inputTextStyle: TextStyle(color: color),
          pixelHeight: 42,
          ontap: () {
            PrimaryScrollController.of(scrollContext).jumpTo(0);

            showBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => BottomSheet(
                    animationController: bottomSheetAnimController,
                    onClosing: () {},
                    builder: (context) {
                      final double screenHeight = DeviceUtils.getScreenHeight(context);
                      final double screenWidth = DeviceUtils.getScreenWidth(context);
                      return Container(
                          height:  screenHeight - screenHeight * 0.53,
                          width: screenWidth,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search, color: CartifyColors.lightGray,),
                            ConstantWidgets.text(context, "Input a text to search", color: CartifyColors.lightGray),
                          ],
                           ),
                        );
                    }));
          },
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: CartifyColors.antiFlashWhite.withAlpha(175), width: 2), borderRadius: BorderRadius.circular(36)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: isDarkMode == true ? CartifyColors.lightPremiumGold.withAlpha(100) : CartifyColors.premiumGold.withAlpha(75),
              ),
              borderRadius: BorderRadius.circular(36)),
        ),
      ),
    );
  }
}
