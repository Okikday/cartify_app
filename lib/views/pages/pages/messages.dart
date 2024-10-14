import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Messages extends ConsumerWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: ConstantWidgets.text(context, "Messages"), centerTitle: true,),

      body: Column(
        children: [
          
        ],
      ),
    );
  }
}