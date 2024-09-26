import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = DeviceUtils.isDarkMode(context);

    // Define frosty background color based on dark mode
    Color frostyBackground = isDarkMode ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2);

    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.only(top: 28, left: 12, right: 12),
        child: Row(
          children: [
            Expanded(
              child: Align(alignment: Alignment.centerLeft,
                child: Container(
                decoration: BoxDecoration(
                  
                  color: frostyBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                            ),
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                color: frostyBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  const SizedBox(
                    width: 52,
                    height: 36,
                    child: Icon(Icons.notifications, color: CartifyColors.aliceBlue)),

                  
                    Positioned(
                      top: 4,
                      right: 8,
                      child: CircleAvatar(child: ConstantWidgets.text(context, "5", fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white), backgroundColor: Colors.red, radius: 8,))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
