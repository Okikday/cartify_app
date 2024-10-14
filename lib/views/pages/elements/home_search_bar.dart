import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/pages/search_view.dart';
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
  late bool isDarkMode;
  late Color color;
  late SimpleWidgetStates simpleWidgetRef;
  bool isBottomBuyNowVisible = false;

  void assignVals() {
    isDarkMode = DeviceUtils.isDarkMode(context);
    color = isDarkMode == true ? CartifyColors.lightGray : CartifyColors.onyxBlack;
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

    return GestureDetector(
      onTap: (){
        DeviceUtils.pushMaterialPage(context, const SearchView());
      },
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
          isEnabled: false,
          backgroundColor: CartifyColors.lightGray.withAlpha(25),
          prefixIcon: Icon(
            Icons.search,
            color: color,
          ),
          hint: "Search a product",
          hintStyle: TextStyle(color: color, fontSize: 14),
          inputTextStyle: TextStyle(color: color),
          pixelHeight: 42,
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: isDarkMode == true ? CartifyColors.lightPremiumGold.withAlpha(75) : CartifyColors.royalBlue.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(36)),
        ),
      ),
    );
  }
}