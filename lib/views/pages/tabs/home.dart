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
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    super.key,
  });

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
    // ignore: unused_result
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // ignore: unused_result
    ref.refresh(productsFutureProvider);
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
                      child: Container(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color.fromARGB(255, 162, 174, 211).withAlpha(100), boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.5), blurStyle: BlurStyle.outer),
                          ]),
                          child: TabPageSelector(
                            selectedColor: Colors.white,
                            controller: tabController,
                          )),
                    )
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
  const HomeBody({super.key, required this.productCategoriesList, this.mainScreenContext});

  final List<Map<String, String>> productCategoriesList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(simpleWidgetProvider).homeBodyScrollContext = context;
    final productsAsyncValue = ref.watch(productsFutureProvider);
    return RefreshIndicator(
      displacement: 20,
      onRefresh: () async {
        // ignore: unused_result
        ref.refresh(productsFutureProvider);
        DeviceUtils.showFlushBar(context, "Products Refreshed!");
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    const HomeSearchBar(),
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
              productsAsyncValue.when(
                data: (products) => Column(children: [
                  for(int i = 0; i < products.length; i++)
                  ProductCard(assetName: products[i].photo, price: products[i].price.toString())
                ],), 
                error: (error, stackTrace) => Center(
                child: SizedBox(
                  height: 200,
                  child: ConstantWidgets.text(context, "Unable to load products"),
                ),
              ),
                loading: () => CircleAvatar(backgroundColor: Colors.transparent,child: CircularProgressIndicator(),),
                )
            ],
          ),
        ),
      ),
    );
  }
}
