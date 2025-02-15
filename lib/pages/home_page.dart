import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:food_delivery_app/components/my_current_location.dart';
import 'package:food_delivery_app/components/my_description_box.dart';
import 'package:food_delivery_app/components/my_drawer.dart';
import 'package:food_delivery_app/components/my_food_tile.dart';
import 'package:food_delivery_app/components/my_sliver_app_bar.dart';
import 'package:food_delivery_app/components/my_tab_bar.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/cart_page.dart';
import 'package:food_delivery_app/pages/food_page.dart';
import 'package:food_delivery_app/pages/settings_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FoodCatagory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    HomeContent(),
    CartPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        buttonBackgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.primary,
        items: [
          Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary),
          Consumer<Restauarant>(
            builder: (context, restauarant, child) {
              final cartItemCount = restauarant.cart.length;
              // Show badge only if cart is not empty
              if (cartItemCount > 0) {
                return Badge(
                  label: Text(cartItemCount.toString()),
                  child: Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.inversePrimary),
                );
              } else {
                // Return just the icon if cart is empty
                return Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.inversePrimary);
              }
            },
          ),
          Icon(Icons.settings, color: Theme.of(context).colorScheme.inversePrimary),
        ],
        index: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      drawer: MyDrawer(),
      body: _pages[_index],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: FoodCatagory.values.length,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: DefaultTabController.of(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                MyCurrentLocation(),
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Restauarant>(
          builder: (context, restauarant, child) => TabBarView(
            controller: DefaultTabController.of(context),
            children: FoodCatagory.values.map((category) {
              List<Food> categoryMenu = restauarant.menu.where((food) => food.catagory == category).toList();
              return ListView.builder(
                itemCount: categoryMenu.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final food = categoryMenu[index];
                  return MyFoodTile(
                    food: food,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodPage(food: food),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}