import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notifications extends ConsumerWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: ConstantWidgets.text(context, "Notifications"), centerTitle: true,),

      body: Column(
        children: [
          
        ],
      ),
    );
  }
}