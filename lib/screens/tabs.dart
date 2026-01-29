import 'package:flutter/material.dart';
import 'package:meals_flutter_app/data/dummy_data.dart';
import 'package:meals_flutter_app/main.dart';
import 'package:meals_flutter_app/screens/categories.dart';
import 'package:meals_flutter_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  Widget mainContent = const CategoriesScreen();
  String appBarTitle = 'Categories';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 1) {
      mainContent = MealsScreen(meals: dummyMeals);
      appBarTitle = 'Favorites';
    } else {
      mainContent = CategoriesScreen();
      appBarTitle = 'Categories';
    }
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: mainContent,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
