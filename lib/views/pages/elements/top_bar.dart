import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/pages/notifications.dart';
import 'package:cartify/views/pages/pages/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget {
  final BuildContext? mainScreenContext;
  const TopBar({super.key, this.mainScreenContext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 52,
                  height: 48,
                  decoration: BoxDecoration(
                    color: frostyBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.search),
                    onPressed: () => DeviceUtils.pushMaterialPage(context, const SearchView()),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => DeviceUtils.pushMaterialPage(context, const Notifications()),
              child: Container(
                width: 52,
                height: 48,
                decoration: BoxDecoration(
                  color: frostyBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    const SizedBox(width: 52, height: 36, child: Icon(Icons.notifications, color: CartifyColors.aliceBlue)),
                    Positioned(
                        top: 4,
                        right: 8,
                        child: CircleAvatar(
                          child: ConstantWidgets.text(context, "1", fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                          backgroundColor: Colors.red,
                          radius: 8,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void setSearchBarFocus(
  //     BuildContext homeSearchBarContext,
  //     {required WidgetRef ref}) {
  //   debugPrint("Setting textfield focus");
  //   if (homeSearchBarContext.mounted) {
  //     //FocusScope.of(homeSearchBarContext).requestFocus(homeSearchBarFocusNode);
  //     activateHomeSearchBar(homeSearchBarContext, ref);
  //   }
  // }
}
