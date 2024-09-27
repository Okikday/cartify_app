import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/test_data.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/home_search_bar.dart';
import 'package:cartify/views/pages/elements/home_space_bar_bg.dart';
import 'package:cartify/views/pages/elements/product_card.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:cartify/views/pages/elements/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Home extends ConsumerStatefulWidget {
  const Home({super.key,});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late TabController tabController;
  late AnimationController searchBodyAnimController;
  //late Animation<double> opacAnim;
  final List<Map<String, String>> slidableMap = TestData.slidableMap;
  final List<Map<String, String>> productCategoriesList = TestData.productCategoriesList;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: slidableMap.length, vsync: this);
    searchBodyAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    // opacAnim = Tween<double>(begin: 0.2, end: 1).animate(searchBodyAnimController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(simpleWidgetProvider).searchBodyAnimController = searchBodyAnimController;
  }

  @override
  Widget build(BuildContext context,) {
    
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
                            child: HomeSpaceBarBg(
                              assetName: slidableMap[i]["assetName"]!,
                              topic: slidableMap[i]["topic"] ?? "not found",
                              description: slidableMap[i]["description"] ?? "not found",
                              imgSrc: slidableMap[i]["imgSrc"] ?? "not found",
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
                        selectedColor: CartifyColors.royalBlue,
                        indicatorSize: 14,
                      ),
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(top: paddingTop + 8), // Adjust the top padding dynamically
                title: const Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(),
                ),
              );
            },
          ),
        ),
      ],
      body: HomeBody(
        productCategoriesList: productCategoriesList,
        
      ),
    );
  }
}

class HomeBody extends ConsumerWidget {
  final BuildContext? mainScreenContext;
  const HomeBody({
    super.key,
    required this.productCategoriesList,
    this.mainScreenContext
  });

  final List<Map<String, String>> productCategoriesList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    ref.read(simpleWidgetProvider).homeBodyScrollContext = context;
    
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  HomeSearchBar(),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list_rounded,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ProductForYou(
              topic: "Recommended for you",
              list: productCategoriesList,
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                color: CartifyColors.lightGray,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstantWidgets.text(context, "Trending", fontSize: 20),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.grid_view_rounded,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold)),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < 9; i++) ProductCard()
          ],
        ),
      ),
    );
  }
}
