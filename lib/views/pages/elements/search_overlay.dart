import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class SearchOverlay{
  OverlayEntry? _overlayEntry;

  void showOverlay(BuildContext context) {
    _overlayEntry = createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
  }

  OverlayEntry createOverlayEntry() {
    return OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (context) => Container(
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
              onPressed: _removeOverlay, // Dismiss overlay when pressed
              child: Text('Close Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}