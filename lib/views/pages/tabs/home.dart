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
      "assetName": "assets/images/electronics_2.png",
      "topic": "Grab the Best Electronics Deals Now",
      "description": "Take advantage of our exclusive discounts on top-notch electronics. Don't miss out!",
      "imgSrc": "offline"
    },
    1: {
      "assetName": "assets/images/home_slider_1.jpg",
      "topic": "Discover Your Style with Modern Interiors",
      "description": "Explore our curated collection of home decor to elevate your living space with contemporary designs.",
      "imgSrc": "offline"
    },
    2: {
      "assetName":
          "assets/images/kitchen_appliance.png",
      "topic": "Modern Kitchen Essentials at Great Prices",
      "description": "Upgrade your kitchen with sleek, modern appliances that fit your budget.",
      "imgSrc": "offline"
    },
  };

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          collapsedHeight: 56,
          expandedHeight: 250,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double currentHeight = constraints.biggest.height;
              const double expandedHeight = 250;
              const double collapsedHeight = 56;
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
                        color: CartifyColors.lightPremiumGold,
                        selectedColor: CartifyColors.premiumGold,
                        indicatorSize: 14,
                      ),
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(top: paddingTop + 8), // Adjust the top padding dynamically
                title: Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(),
                ),
              );
            },
          ),
        ),
      ],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(36)),
          child: Column(
            children: [
          
              ProductCategories(topic: "Trending", list: [
                {
                  "name": "Iphone 15 pro max",
                  "description": "Brand new",
                  "assetName": "assets/images/iphone_15_pm_nobg.png",
                  "price" : "#1,700,000"
                },
                 {
                  "name": "Iphone 15 pro max",
                  "description": "Brand new",
                  "assetName": "assets/images/iphone_15_pm_nobg.png",
                  "price" : "#1,700,000"
                },
                 {
                  "name": "Iphone 15 pro max",
                  "description": "Brand new",
                  "assetName": "assets/images/iphone_15_pm.jpg",
                  "price" : "#1,700,000"
                }
              ],)
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = DeviceUtils.isDarkMode(context);

    // Define frosty background color based on dark mode
    Color frostyBackground = isDarkMode 
      ? Colors.white.withOpacity(0.2) 
      : Colors.black.withOpacity(0.2);

    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.only(top: 28, left: 12, right: 12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: frostyBackground, // Frosty background
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(FluentIcons.list_24_filled,),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: frostyBackground, // Frosty background
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 8), // Add some spacing
            Container(
              decoration: BoxDecoration(
                color: frostyBackground, // Frosty background
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BgWidget extends StatelessWidget {
  final String assetName;
  final String topic;
  final String description;
  final String imgSrc;

  const BgWidget({super.key, required this.assetName, required this.topic, required this.description, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcATop),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: imgSrc == "online" ? NetworkImage(assetName) : AssetImage(assetName), fit: BoxFit.cover,)),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
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

