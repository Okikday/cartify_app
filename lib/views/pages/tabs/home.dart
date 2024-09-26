import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/data/test_data.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/pages/elements/home_space_bar_bg.dart';
import 'package:cartify/views/pages/elements/product_card.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:cartify/views/pages/elements/top_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController tabController;
  late AnimationController opacAnimController;
  late Animation<double> opacAnim;
  final List<Map<String, String>> slidableMap = TestData.slidableMap;
  final List<Map<String, String>> productCategoriesList = TestData.productCategoriesList;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: slidableMap.length, vsync: this);
    opacAnimController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    opacAnim = Tween<double>(begin: 0.2, end: 1).animate(opacAnimController);
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
        opacAnimController: opacAnimController,
        opacAnim: opacAnim,
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final AnimationController opacAnimController;
  final Animation<double> opacAnim;
  const HomeBody({
    super.key,
    required this.productCategoriesList,
    required this.opacAnimController,
    required this.opacAnim,
  });

  final List<Map<String, String>> productCategoriesList;

  @override
  Widget build(BuildContext context) {
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
                  homeSearchBar(context),
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
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

  Expanded homeSearchBar(BuildContext context) {
    return Expanded(
      child: CustomTextfield(
        backgroundColor: CartifyColors.lightGray,
        borderRadius: 24,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        hint: "Search a product",
        hintStyle: TextStyle(color: Colors.black),
        pixelHeight: 52,
        ontap: () {
          PrimaryScrollController.of(context).jumpTo(240);
          print("Overlay");
          // SearchOverlay().showOverlay(context, opacAnim, opacAnimController);
          // opacAnimController.forward();

          // showBottomSheet(
          //     context: context,
          //     builder: (context) => BottomSheet(
          //         onClosing: () {},
          //         builder: (context) => Container(
          //               height: 200,
          //               color: Colors.blue,
          //             )));
        },
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CartifyColors.royalBlue.withAlpha(175), width: 2)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: CartifyColors.royalBlue.withAlpha(75),
            ),
            borderRadius: BorderRadius.circular(36)),
      ),
    );
  }
}
