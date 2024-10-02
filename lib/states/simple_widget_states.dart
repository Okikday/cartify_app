import 'package:cartify/views/pages/elements/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleWidgetProvider = ChangeNotifierProvider<SimpleWidgetStates>((ref) => SimpleWidgetStates());

class SimpleWidgetStates extends ChangeNotifier{

  //main Screen
  late BuildContext mainScreenContext;

  //home page
  late BuildContext homeSearchBarContext;
  late BuildContext homeBodyScrollContext;
  late FocusNode homeSearchBarFocusNode;
  late AnimationController searchBodyAnimController;
  late bool isSearchBodyVisible = false;

  //Orders page
  bool isOrdersBottomBarBuyNowVisible = true;
  


  bool isProductInfoImageTabVisible = false;
  late AnimationController imageInteractiveViewAnimController;
  
  void initImageInteractiveAnimController(TickerProvider vsync) {
    imageInteractiveViewAnimController = AnimationController(duration: const Duration(milliseconds: 400), vsync: vsync);
  }

  void reverseImageInteractiveAnimController(BuildContext context) {
    imageInteractiveViewAnimController.reverse();
    Future.delayed(const Duration(milliseconds: 410), () {
      if(context.mounted) CustomOverlay(context).removeOverlay();
      isProductInfoImageTabVisible = false;
      imageInteractiveViewAnimController.dispose();
      notifyListeners();
    });
  }
}
  
  

  



