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
  
  
  
  

  



}