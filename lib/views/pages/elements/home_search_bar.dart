import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSearchBar extends ConsumerStatefulWidget {
  const HomeSearchBar({
    super.key,
  });

  static bool isSearchBarActivated = false;

  @override
  ConsumerState<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends ConsumerState<HomeSearchBar> {
  final FocusNode focusNode = FocusNode();
  late bool isDarkMode;
  late Color color;
  late SimpleWidgetStates simpleWidgetRef;
  bool isBottomBuyNowVisible = false;

  // @override
  // void initState() {
  //   super.initState();

  //   focusNode.addListener(focusNodeListener);
  // }

  void assignVals() {
    simpleWidgetRef = ref.watch(simpleWidgetProvider);
    isDarkMode = DeviceUtils.isDarkMode(context);
    color = isDarkMode == true ? CartifyColors.lightGray : CartifyColors.onyxBlack;
    simpleWidgetRef.homeSearchBarContext = context;
    simpleWidgetRef.homeSearchBarFocusNode = focusNode;
  }

  // void focusNodeListener(){
  //   if(!focusNode.hasFocus && isBottomBuyNowVisible == true){
  //     Navigator.pop(context);
  //     isBottomBuyNowVisible = false;
  //   }
  // }

  // @override
  // void dispose() {
  //   focusNode.removeListener(focusNodeListener);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    assignVals();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [
          BoxShadow(color: CartifyColors.royalBlue.withAlpha(75), blurRadius: 4, blurStyle: BlurStyle.inner),
          const BoxShadow(
            color: Colors.black54,
            blurRadius: 2,
            offset: Offset(1, 1),
            blurStyle: BlurStyle.outer,
          )
        ]),
        child: CustomTextfield(
          focusNode: focusNode,
          backgroundColor: CartifyColors.lightGray.withAlpha(25),
          prefixIcon: Icon(
            Icons.search,
            color: color,
          ),
          hint: "Search a product",
          hintStyle: TextStyle(color: color, fontSize: 14),
          inputTextStyle: TextStyle(color: color),
          pixelHeight: 42,
          ontap: () {
            activateHomeSearchBar(context, simpleWidgetRef.homeBodyScrollContext, simpleWidgetRef.searchBodyAnimController, ref, todo: () {
              isBottomBuyNowVisible = true;
            });
          },
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: CartifyColors.antiFlashWhite.withAlpha(175), width: 2), borderRadius: BorderRadius.circular(36)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: isDarkMode == true ? CartifyColors.lightPremiumGold.withAlpha(100) : CartifyColors.premiumGold.withAlpha(25),
              ),
              borderRadius: BorderRadius.circular(36)),
        ),
      ),
    );
  }
}

void activateHomeSearchBar(
  BuildContext context,
  BuildContext scrollContext,
  AnimationController searchBodyAnimController,
  WidgetRef ref, {
  void Function()? todo,
}) {
  PrimaryScrollController.of(scrollContext).jumpTo(0);
  ref.read(simpleWidgetProvider).isSearchBodyVisible = true;
  todo == null ? () {} : todo();
  showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BottomSheet(
          animationController: searchBodyAnimController,
          onClosing: () {},
          builder: (context) {
            final double screenHeight = DeviceUtils.getScreenHeight(scrollContext);
            final double screenWidth = DeviceUtils.getScreenWidth(scrollContext);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.decelerate,
              height: DeviceUtils.isKeyboardVisible(context) == true ? screenHeight - screenHeight * 0.53 : screenHeight - screenHeight * 0.25,
              width: screenWidth,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search,
                    color: CartifyColors.lightGray,
                  ),
                  ConstantWidgets.text(context, "Input a text to search", color: CartifyColors.lightGray),
                ],
              ),
            );
          }));
}
