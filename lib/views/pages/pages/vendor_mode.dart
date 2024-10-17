import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/tabs/manage_products_view.dart';
import 'package:cartify/views/pages/tabs/orders_requests_view.dart';
import 'package:cartify/views/pages/tabs/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorMode extends ConsumerStatefulWidget {
  const VendorMode({super.key});

  @override
  ConsumerState<VendorMode> createState() => _VendorModeState();
}

class _VendorModeState extends ConsumerState<VendorMode> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ManageProductsView(),
    OrderRequestsView(),
    ProfileView(),
    EarningsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    return Scaffold(
      
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        indicatorColor: CartifyColors.premiumGold,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(icon: Icon(Icons.upload, color: CartifyColors.battleshipGrey,), selectedIcon: Icon(Icons.upload, color: isDarkMode ? Colors.white : CartifyColors.jetBlack,), label: "Manage", ),
          NavigationDestination(icon: Icon(Icons.more, color: CartifyColors.battleshipGrey,), label: "Requests", selectedIcon: Icon(Icons.more, color: isDarkMode ? Colors.white : CartifyColors.jetBlack),),
          NavigationDestination(icon: Icon(Icons.person, color: CartifyColors.battleshipGrey,), label: "Profile", selectedIcon: Icon(Icons.person, color: isDarkMode ? Colors.white : CartifyColors.jetBlack),),
          NavigationDestination(icon: Icon(Icons.attach_money, color: CartifyColors.battleshipGrey,), label: "Earnings", selectedIcon: Icon(Icons.attach_money, color: isDarkMode ? Colors.white : CartifyColors.jetBlack),),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}



class EarningsView extends ConsumerStatefulWidget {
  const EarningsView({super.key});

  @override
  ConsumerState<EarningsView> createState() => _EarningsViewState();
}

class _EarningsViewState extends ConsumerState<EarningsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kToolbarHeight + 24, child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
          const BackButton(),
          Expanded(child: ConstantWidgets.text(context, "Earnings", fontSize: 16, fontWeight: FontWeight.bold)),
        ],),),),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                ConstantWidgets.text(context, 'Total Earnings: N120,000', fontSize: 24),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Withdraw'),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
