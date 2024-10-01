import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConstantWidgets.text(
              context,
              "What would you like to shop?",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
        
          height: MediaQuery.of(context).size.height * 0.8,
          child: CategoriesGrid(),
        ),
      ],
    );
  }
}

class CategoriesGrid extends StatelessWidget {
  CategoriesGrid({super.key});
  final List<Map<String, String>> categories = [
    {"title": "Trending", "icon": "assets/images/trending.png"},
    {"title": "Vehicles", "icon": "assets/images/car.png"},
    {"title": "Property", "icon": "assets/images/house.png"},
    {"title": "Phones & Tablets", "icon": "assets/images/iphone.png"},
    {"title": "Electronics", "icon": "assets/images/electronics.png"},
    {"title": "Home & Garden", "icon": "assets/images/house_1.png"},
    {"title": "Beauty", "icon": "assets/images/shampoo.png"},
    {"title": "Sports", "icon": "assets/images/sports.png"},
    {"title": "Jobs", "icon": "assets/images/job.png"},
    {"title": "Services", "icon": "assets/images/customer-service.png"},
    {"title": "Babies & Kids", "icon": "assets/images/toys.png"},
    {"title": "Animals & Pets", "icon": "assets/images/pets.png"},
    {"title": "Food and drinks", "icon": "assets/images/diet.png"},
    {"title": "Equipment & Tools", "icon": "assets/images/tools.png"},
    {"title": "Repair & Construction", "icon": "assets/images/architect.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 24, // Horizontal space between grid items
        mainAxisSpacing: 12, // Vertical space between grid items
        childAspectRatio: 0.8, // Aspect ratio for grid items
      ),
      physics: const BouncingScrollPhysics(), // Disable internal scrolling
      scrollDirection: Axis.vertical,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: CartifyColors.royalBlue.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 2, color: CartifyColors.royalBlue.withAlpha(25)),
                boxShadow: DeviceUtils.isDarkMode(context) == true ? 
        [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: Offset(0, 0), blurStyle: BlurStyle.inner, spreadRadius: 2),]
         : [BoxShadow(color: CartifyColors.royalBlue.withOpacity(0.1), blurRadius: 8, offset: Offset(0, 0), blurStyle: BlurStyle.inner, spreadRadius: 2),],
              ),
              child: Image.asset(
                categories[index]["icon"]!,
              ),
            ),
            const SizedBox(height: 5),
            ConstantWidgets.text(
              context,
              categories[index]["title"]!,
              align: TextAlign.center,
              fontSize: 11,
            ),
          ],
        );
      },
    );
  }
}
