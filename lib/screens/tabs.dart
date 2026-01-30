import 'package:flutter/material.dart';
import 'package:meals_flutter_app/data/dummy_data.dart';
import 'package:meals_flutter_app/models/meal.dart';
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
  String appBarTitle = 'Categories';
  int selectedIndex = 0;

  final List<Meal> _favoriteMeals = [];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void onToggleFavoriteMeal(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
        _showMessage('Removed from favorites');
      } else {
        _favoriteMeals.add(meal);
        _showMessage('Added to favorites');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent;

    if (selectedIndex == 1) {
      mainContent = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavoriteMeal: onToggleFavoriteMeal,
      );
      appBarTitle = 'Favorites';
    } else {
      mainContent = CategoriesScreen(
        onToggleFavoriteMeal: onToggleFavoriteMeal,
      );
      appBarTitle = 'Categories';
    }
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: mainContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
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
