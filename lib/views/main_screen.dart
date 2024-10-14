import 'package:cartify/app.dart';
import 'package:cartify/services/test_api.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/bottom_nav_bar.dart';
import 'package:cartify/views/pages/tabs/account.dart';
import 'package:cartify/views/pages/tabs/categories.dart';
import 'package:cartify/views/pages/tabs/home.dart';
import 'package:cartify/views/pages/tabs/orders.dart';
import 'package:cartify/views/pages/tabs/wishlists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController tabController;
  late int currentIndex;
  static DateTime? lastBackPressTime;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    currentIndex = 0;
    tabController.addListener(() => setState(() {
          currentIndex = tabController.index;
        }));
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final connectOutcome = await TestApi.testConnect();
      if (globalNavKey.currentContext!.mounted && connectOutcome != null) DeviceUtils.showFlushBar(globalNavKey.currentContext!, connectOutcome);
    });
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(simpleWidgetProvider).mainScreenContext = context;
    DeviceUtils.setFullScreen(false);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (currentIndex == 0) {
            DateTime now = DateTime.now();
      
            if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(milliseconds: 2500)) {
              lastBackPressTime = now;
              DeviceUtils.showFlushBar(context, "Repeat action to exit!");
            } else {
              SystemNavigator.pop();
            }
          } else {
            setState(() => tabController.index = currentIndex = 0);
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() => tabController.index = currentIndex = index);
            },
          ),
          body: TabBarView(physics: const NeverScrollableScrollPhysics(), controller: tabController, children: const [
            Tab(
              child: Home(),
            ),
            Tab(
              child: Categories(),
            ),
            Tab(
              child: Orders(),
            ),
            Tab(
              child: Wishlists(),
            ),
            Tab(
              child: Account(),
            ),
          ]),
        ),
      ),
    );
  }
}
