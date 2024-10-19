import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Messages extends ConsumerWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: ConstantWidgets.text(context, "Messages"), centerTitle: true,),

      body: Column(
        children: [
          for(int i = 0; i < 3; i++)
          const MessageListTile(title: "Mr. Vendor")
        ],
      ),
    );
  }
}

class MessageListTile extends StatelessWidget {
  final String? title;

  const MessageListTile({super.key, required this.title,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                  ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ConstantWidgets.text(context, title, adjustSize: 4, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                            const SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        ConstantWidgets.text(context, "How many do you need sir?", color: CartifyColors.battleshipGrey, darkColor: CartifyColors.lightGray, overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  ),
                ),
              ),

              CircleAvatar(radius: 11, backgroundColor: Colors.red, child: ConstantWidgets.text(context, "1", color: Colors.white, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
