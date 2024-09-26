import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:flutter/material.dart';

class SearchOverlay{
  OverlayEntry? _overlayEntry;
  

  void showOverlay(BuildContext context, Animation<double> opacVal, AnimationController controller) {
    _overlayEntry = createOverlayEntry(opacVal, controller);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay(AnimationController controller) {
    controller.reverse();
    Future.delayed(Duration(milliseconds: 150), (){
      _overlayEntry?.remove();
    });
  }

  OverlayEntry createOverlayEntry(Animation<double> opacVal, AnimationController controller) {
    return OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (context) => FadeTransition(
            opacity: opacVal,
            child: Container(
              margin: EdgeInsets.only(top: 156, bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstantWidgets.text(context, "Overlay texts and things"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _removeOverlay(controller), // Dismiss overlay when pressed
                    child: Text('Close Overlay'),
                  ),
                ],
              ),
            ),
          )
    );
  }
}