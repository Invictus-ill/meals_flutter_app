import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_flutter_app/models/meal.dart';
import 'package:meals_flutter_app/providers/favorites_provider.dart';
import 'package:meals_flutter_app/providers/filters_provider.dart';
import 'package:meals_flutter_app/providers/meals_provider.dart';
import 'package:meals_flutter_app/screens/categories.dart';
import 'package:meals_flutter_app/screens/filters.dart';
import 'package:meals_flutter_app/screens/meals.dart';
import 'package:meals_flutter_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  String appBarTitle = 'Categories';
  int selectedIndex = 0;

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent;

    List<Meal> meals = ref.watch(mealsProvider);
    Map<Filters, bool> activeFilters = ref.watch(FiltersProvider);

    final availableMeals = meals.where((meal) {
      if (!meal.isGlutenFree && activeFilters[Filters.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && activeFilters[Filters.lactoseFree]!) {
        return false;
      }
      if (!meal.isVegan && activeFilters[Filters.vegan]!) {
        return false;
      }
      if (!meal.isVegetarian && activeFilters[Filters.vegetarian]!) {
        return false;
      }
      return true;
    }).toList();

    if (selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      mainContent = MealsScreen(meals: favoriteMeals);
      appBarTitle = 'Favorites';
    } else {
      mainContent = CategoriesScreen(availableMeals: availableMeals);
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
      drawer: MainDrawer(onSelectScreen: _setScreen),
    );
  }
}
