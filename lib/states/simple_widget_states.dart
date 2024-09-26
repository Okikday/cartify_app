import 'package:flutter/material.dart';

class SimpleWidgetStates extends ChangeNotifier{

  late BuildContext homeSearchBarContext;

  void setSearchBarFocus(){
    debugPrint("Setting textfield focus");
    if(homeSearchBarContext.mounted){
      FocusScope.of(homeSearchBarContext).setFirstFocus;
    }
  }



}