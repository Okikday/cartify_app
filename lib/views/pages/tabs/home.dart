import 'package:cartify/views/pages/elements/home_drawer_button.dart';
import 'package:cartify/views/pages/elements/home_search_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) => [
        SliverAppBar(
          elevation: 10,
          collapsedHeight: 64,
          expandedHeight: 64,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var top = constraints.biggest.height;
              var movementOffset = (top - 64) / 64; 

              return FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  
                  offset: Offset(0, -movementOffset * 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 64,
                      child: Row(
                        children: [
                          HomeDrawerButton(),
                          const SizedBox(width: 16),
                          Expanded(child: HomeSearchBar()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          color: Colors.grey,
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Center(child: Text('Item $index')),
        ),
      ),
    );
  }
}
