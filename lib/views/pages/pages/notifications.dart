import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notifications extends ConsumerWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: ConstantWidgets.text(context, "Notifications", fontSize: 14, fontWeight: FontWeight.bold), centerTitle: true,),

      body: Column(
        children: [
          const Divider(),
          for (int i = 0; i < 5; i++)
          Column(
            children: [
              NotificationListTile(title: "Remember to monitor your earnings, vendor", index: i,),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}


class NotificationListTile extends StatelessWidget {
  final int index;
  final String title;
  const NotificationListTile({
    super.key,
    required this.title,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: ConstantWidgets.text(context, index.toString(), fontWeight: FontWeight.bold, fontSize: 14),),
      title: ConstantWidgets.text(context, title),
      trailing: ConstantWidgets.text(context, "5m ago", color: CartifyColors.battleshipGrey, darkColor: CartifyColors.lightGray, fontSize: 10),
    );
  }
}
