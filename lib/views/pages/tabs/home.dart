import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) => [
        SliverAppBar(
          elevation: 10,
          collapsedHeight: 64,
          expandedHeight: 250,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {

              return FlexibleSpaceBar(
                expandedTitleScale: 1.1,
                background: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      TabBarView(
                        controller: tabController,
                        children: [
                        Tab(child: Image.asset("assets/images/home_slider_1.jpg", fit: BoxFit.cover,),),
                        Tab(child: Image.asset("assets/images/home_slider_2.jpg", fit: BoxFit.fill,),),
                        Tab(child: Image.asset("assets/images/home_slider_3.jpg", fit: BoxFit.cover,),),
                      ]),
                  
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Column(
                        children: [
                          TopBar(),
                          ConstantWidgets.text(context, "Discover new and quality products for your needs", color: Colors.white, fontSize: 26,),
                          ConstantWidgets.text(context, "Discover new and quality products for your needs", color: Colors.white),
                        ],
                      ))
                    ],
                  ),
                ),
                titlePadding: const EdgeInsets.all(0),

                title: TopBar(),
              );
            },
          ),
        ),
      ],
      body: Container()
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: ImageFiltered(
          imageFilter: const ColorFilter.mode(Color.fromARGB(160, 0, 0, 0), BlendMode.color),
          child: Row(
            children: [
              Expanded(child: Align(alignment: Alignment.centerLeft, child: IconButton(icon: Icon(FluentIcons.list_24_filled), onPressed: (){},))),
              IconButton(icon: Icon(Icons.search), onPressed: (){},),
              IconButton(icon: Icon(Icons.shopping_bag_outlined), onPressed: (){},),
            ],
          ),
        ),
      ),
    );
  }
}





class CategoriesBox extends StatelessWidget {

  const CategoriesBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: [
            Container(
              width: 48,
              height: 48,
              color: Colors.blue,
              child: Icon(Icons.abc),
            )
      ],
    );
}
}