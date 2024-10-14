import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight,),
          const Row(
            children: [
              BackButton(),
              ProductSearchBar(),
            ],
          ),
          Expanded(
            child: Container(
              child: Center(child: ConstantWidgets.text(context, "Input a text to search")),
            ),
          ),
        ],
      ),
    );
  }
}


class ProductSearchBar extends ConsumerStatefulWidget {
  const ProductSearchBar({super.key});

  @override
  ConsumerState<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends ConsumerState<ProductSearchBar> {
  late bool isDarkMode;
  late Color color;
  bool isBottomBuyNowVisible = false;

  void assignVals() {
    isDarkMode = DeviceUtils.isDarkMode(context);
    color = isDarkMode == true ? CartifyColors.lightGray : CartifyColors.onyxBlack;
  }
  @override
  Widget build(BuildContext context) {
    assignVals();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 16),
        child: CustomTextfield(
          isEnabled: true,
          backgroundColor: CartifyColors.lightGray.withAlpha(25),
          prefixIcon: Icon(
            Icons.search,
            color: color,
          ),
          hint: "Enter a product name",
          hintStyle: TextStyle(color: color, fontSize: 14),
          inputTextStyle: TextStyle(color: color),
          pixelHeight: 42,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: isDarkMode == true ? CartifyColors.lightPremiumGold.withAlpha(75) : CartifyColors.royalBlue.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: isDarkMode == true ? CartifyColors.lightPremiumGold.withAlpha(75) : CartifyColors.royalBlue.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}