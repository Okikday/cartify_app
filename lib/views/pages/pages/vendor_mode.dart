import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
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
    RequestsView(),
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

class ManageProductsView extends ConsumerStatefulWidget {
  const ManageProductsView({super.key});

  @override
  ConsumerState<ManageProductsView> createState() => _ManageProductsViewState();
}

class _ManageProductsViewState extends ConsumerState<ManageProductsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kToolbarHeight + 24, child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
          const BackButton(),
          Expanded(child: ConstantWidgets.text(context, "Manage Products", fontSize: 16, fontWeight: FontWeight.bold)),
        ],),),),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 6, bottom: 24),
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Product ${index + 1}'),
                subtitle: Text('Product details here'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RequestsView extends ConsumerStatefulWidget {
  const RequestsView({super.key});

  @override
  ConsumerState<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends ConsumerState<RequestsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kToolbarHeight + 24, child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
          const BackButton(),
          Expanded(child: ConstantWidgets.text(context, "Requests", fontSize: 16, fontWeight: FontWeight.bold)),
        ],),),),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 6, bottom: 24),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Request ${index + 1}'),
                subtitle: Text('Request details here'),
                trailing: ElevatedButton(
                  child: Text('Approve'),
                  onPressed: () {
                    
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kToolbarHeight + 24, child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
          const BackButton(),
          Expanded(child: ConstantWidgets.text(context, "Profile", fontSize: 16, fontWeight: FontWeight.bold)),
        ],),),),
        Expanded(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                const SizedBox(height: 16),
                Text('Vendor Name', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                Text('Vendor Email', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Edit Profile'),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),),
      ],
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
              children: [
                const SizedBox(height: 16),
                Text('Total Earnings: \$2000', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Withdraw'),
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
