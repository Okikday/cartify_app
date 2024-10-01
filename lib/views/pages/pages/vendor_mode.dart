import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorMode extends ConsumerWidget {
  const VendorMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: [
          NavigationDestination(icon: Icon(Icons.upload), label: "Manage Products"),
          NavigationDestination(icon: Icon(Icons.more), label: "Requests"),
          ]),
      body: Container(),
    );
  }
}
