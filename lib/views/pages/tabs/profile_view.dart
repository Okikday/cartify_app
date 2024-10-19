import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                const SizedBox(height: 16),
                ConstantWidgets.text(context, "Vendor name", fontSize: 24),
                const SizedBox(height: 8),
                ConstantWidgets.text(context, "Vendor Email", fontSize: 16),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Edit Profile'),
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