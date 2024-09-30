import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final bool canPop;
  const LoadingDialog({super.key, this.canPop = false});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = DeviceUtils.getScreenWidth(context);
    return PopScope(
      canPop: canPop,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(36)),
                width: screenWidth * 0.6,
                height: screenWidth * 0.4,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(backgroundColor: Colors.transparent, child: CircularProgressIndicator(strokeCap: StrokeCap.round,)),
                      const SizedBox(height: 16,),
                      ConstantWidgets.text(context, "Just a moment..."),
                    ],
                  ),
                ))),
      ),
    );
  }
}
