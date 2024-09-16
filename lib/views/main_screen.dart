import 'package:cartify/views/page_elements/bottom_nav_bar.dart';
import 'package:cartify/views/pages/tabs/account.dart';
import 'package:cartify/views/pages/tabs/categories.dart';
import 'package:cartify/views/pages/tabs/home.dart';
import 'package:cartify/views/pages/tabs/orders.dart';
import 'package:cartify/views/pages/tabs/wishlists.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
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
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: currentIndex, onTap: (index){setState(() => tabController.index = currentIndex = index);},),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: const [
          Tab(child: Home(),),
          Tab(child: Categories(),),
          Tab(child: Orders(),),
          Tab(child: Wishlists(),),
          Tab(child: Account(),),
        ])
      ),
    );
  }
}