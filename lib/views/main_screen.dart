import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/bottom_nav_bar.dart';
import 'package:cartify/views/pages/tabs/account.dart';
import 'package:cartify/views/pages/tabs/categories.dart';
import 'package:cartify/views/pages/tabs/home.dart';
import 'package:cartify/views/pages/tabs/orders.dart';
import 'package:cartify/views/pages/tabs/wishlists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  late TabController tabController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    currentIndex = 0;
    tabController.addListener(() => setState(() {
      currentIndex = tabController.index;
    }));
  }


  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     ref.read(simpleWidgetProvider).mainScreenContext = context;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: currentIndex, onTap: (index){setState(() => tabController.index = currentIndex = index);},),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
        const Tab(child: Home(),),
        const Tab(child: Categories(),),
        const Tab(child: Orders(),),
        const Tab(child: Wishlists(),),
        Tab(child: Account(),),
      ]),
    );
  }
}