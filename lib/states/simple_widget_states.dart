import 'package:cartify/views/pages/elements/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleWidgetProvider = ChangeNotifierProvider<SimpleWidgetStates>((ref) => SimpleWidgetStates());

class SimpleWidgetStates extends ChangeNotifier{
  //main Screen
  late BuildContext mainScreenContext;
  final ScrollController homeBodyScrollController = ScrollController();

  //home page

  //late FocusNode homeSearchBarFocusNode;

  //Orders page
  bool isOrdersBottomBarBuyNowVisible = true;

  bool isProductInfoImageTabVisible = false;
  late AnimationController imageInteractiveViewAnimController;


  //Functions
  
  void reverseImageInteractiveAnimController(BuildContext context) {
    imageInteractiveViewAnimController.reverse();
    Future.delayed(const Duration(milliseconds: 260), () {
      if(context.mounted) CustomOverlay(context).removeOverlay();
      isProductInfoImageTabVisible = false;
      imageInteractiveViewAnimController.dispose();
      notifyListeners();
    });
  }

 


  
  
}
  
  

  



