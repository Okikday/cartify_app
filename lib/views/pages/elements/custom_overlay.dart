import 'package:flutter/material.dart';

class CustomOverlay {
  static OverlayEntry? _overlayEntry;
  final BuildContext context;

  CustomOverlay(this.context);

  void showOverlay({required Widget child}) {
    if (_overlayEntry != null) {
      removeOverlay();
    }
    _overlayEntry = createOverlayEntry(child);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void removeOverlay() {
    if (context.mounted && _overlayEntry != null) {
      _overlayEntry!.remove();
    }
    _overlayEntry = null;
  }

  bool isOverlayMounted() => _overlayEntry != null;

  OverlayEntry createOverlayEntry(Widget child) {
    return OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (context) => child,
    );
  }
}
