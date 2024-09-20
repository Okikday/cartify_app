import 'dart:ui';

import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/product_categories.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;

  Map<int, Map<String, String>> slidableMap = {
  0: {
    "assetName":
        "https://media.istockphoto.com/id/2037146628/photo/modern-simple-small-kitchen-corner-in-the-grey-and-white-kitchen-kitchen.webp?b=1&s=612x612&w=0&k=20&c=yQzn-X6UVVG56Bhfx3Z_0zElN7FMZ770iQwwRR80z4A=",
    "topic": "Modern Kitchen Essentials at Great Prices",
    "description":
        "Upgrade your kitchen with sleek, modern appliances that fit your budget.",
    "imgSrc": "online"
  },

  1: {
    "assetName": "assets/images/home_slider_1.jpg",
    "topic": "Discover Your Style with Modern Interiors",
    "description":
        "Explore our curated collection of home decor to elevate your living space with contemporary designs.",
    "imgSrc": "offline"
  },

  2: {
    "assetName":
        "https://media.istockphoto.com/id/1328130815/photo/yellow-kitchen-appliances-on-yellow-background-set-of-home-kitchen-technics.webp?b=1&s=612x612&w=0&k=20&c=XbLMYvkYKeyDqWYOwer6Aejwz4IOsBP6_qG8BrlHT5E=",
    "topic": "Grab the Best Electronics Deals Now",
    "description":
        "Take advantage of our exclusive discounts on top-notch electronics. Don't miss out!",
    "imgSrc": "online"
  },
};

static const List products = [
    ["Oscar Barbershop","\$449.99", "assets/images/home_slider_1.jpg"],
    ["Old Town", "\$449.99", "assets/images/home_slider_2.jpg"],
    ["NYC Barber Shop", "\$449.99", "assets/images/home_slider_1.jpg"],
    ["Smartstyle", "\$449.99", "assets/images/home_slider_2.jpg"],
    ["Barber Republic", "\$449.99", "assets/images/home_slider_1.jpg"],
    ["Stylofista", "\$449.99", "assets/images/home_slider_2.jpg"]
  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: slidableMap.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    DeviceUtils.setStatusBarColor(Theme.of(context).scaffoldBackgroundColor, DeviceUtils.isDarkMode(context) == true ? Brightness.light : Brightness.dark);
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) => [
        SliverAppBar(
          collapsedHeight: 64,
          expandedHeight: 250,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double currentHeight = constraints.biggest.height;
              const double expandedHeight = 250;
              const double collapsedHeight = 64;
              final double paddingTop = (currentHeight - collapsedHeight) / (expandedHeight - collapsedHeight) * 16;

              return FlexibleSpaceBar(
                expandedTitleScale: 1.1,
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  children: [
                    TabBarView(controller: tabController, children: [
                      for (int i = 0; i < slidableMap.length; i++)
                        SizedBox(
                          height: expandedHeight,
                          child: Tab(
                            child: BgWidget(
                              assetName: slidableMap[i]!["assetName"]!,
                              topic: slidableMap[i]!["topic"] ?? "not found",
                              description: slidableMap[i]!["description"] ?? "not found",
                              tabController: tabController,
                              imgSrc: slidableMap[i]!["imgSrc"] ?? "not found",
                            ),
                          ),
                        )
                    ]),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: TabPageSelector(
                        controller: tabController,
                        color: CartifyColors.lightGray,
                        selectedColor: Colors.white,
                        indicatorSize: 14,
                      ),
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(top: paddingTop), // Adjust the top padding dynamically
                title: Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(
                    iconColor: DeviceUtils.isDarkMode(context) == true
                        ? (currentHeight <= 90 ? Colors.white : Colors.white)
                        : (currentHeight <= 90 ? Colors.black : Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
      body: const Column(
        children: [
          ProductCategories(topic: "New arrivals", list: products)
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final Color iconColor;
  const TopBar({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 4, right: 16),
            child: IconButton(
              icon: const Icon(FluentIcons.list_24_filled, color: Colors.white),
              onPressed: () {},
            ),
          )),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class BgWidget extends StatelessWidget {
  final String assetName;
  final String topic;
  final String description;
  final TabController tabController;
  final String imgSrc;

  const BgWidget({super.key, required this.assetName, required this.topic, required this.description, required this.tabController, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          decoration: BoxDecoration(image: DecorationImage(image: imgSrc == "online" ? NetworkImage(assetName) : AssetImage(assetName), fit: BoxFit.cover, filterQuality: FilterQuality.medium)),
        ),
        Container(
          padding: const EdgeInsets.only(top: 64, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstantWidgets.text(context, topic, fontSize: 28, fontWeight: FontWeight.bold, color: CartifyColors.antiFlashWhite),
              const SizedBox(
                height: 16,
              ),
              ConstantWidgets.text(context, description, color: Colors.white),
            ],
          ),
        )
      ],
    );
  }
}
