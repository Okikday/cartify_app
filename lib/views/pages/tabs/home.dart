import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/data/test_data.dart';
import 'package:cartify/services/test_api.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/trending_section.dart';
import 'package:cartify/views/pages/elements/home_search_bar.dart';
import 'package:cartify/views/pages/elements/home_space_bar_bg.dart';
import 'package:cartify/views/pages/elements/product_for_you.dart';
import 'package:cartify/views/pages/elements/top_bar.dart';
import 'package:flutter/material.dart';
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
  //late Animation<double> opacAnim;
  final List<Map<String, String>> slidableMap = TestData.slidableMap;
  final List<Map<String, String>> productCategoriesList = TestData.productCategoriesList;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: slidableMap.length, vsync: this);
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    DeviceUtils.setStatusBarColor(Theme.of(context).scaffoldBackgroundColor, DeviceUtils.isDarkMode(context) == true ? Brightness.light : Brightness.dark);
    return NestedScrollView(
      controller: ref.watch(simpleWidgetProvider).homeBodyScrollController,
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color.fromARGB(255, 162, 174, 211).withAlpha(100),
                              boxShadow: [
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
    return RefreshIndicator(
      displacement: 20,
      onRefresh: () async {
        // ignore: unused_result
        ref.refresh(productsFutureProvider);
        
        final String? canConnect = await TestApi.testConnect();
        if(context.mounted){
            if(canConnect == null){
              DeviceUtils.showFlushBar(context, "Products Refreshed!");
            }else{
              DeviceUtils.showFlushBar(context, canConnect);
            }
          }
        
        
      },
      child: const CustomScrollView(
        
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: HomeSearchBar()),
          ),
          SliverToBoxAdapter(
            child: ProductForYou(topic: "Recommended for you"),
          ),
          SliverToBoxAdapter(child: TrendingSectionHeader()),
          
          TrendingSection(),
        ],
      ),
    );
  }
}
