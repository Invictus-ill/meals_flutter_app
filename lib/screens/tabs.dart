import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_flutter_app/models/meal.dart';
import 'package:meals_flutter_app/providers/favorites_provider.dart';
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

  Map<Filters, bool> _selectedFilters = kInitialFilters;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final filters = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) =>
              FiltersScreen(initialFiltersState: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = filters ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent;

    List<Meal> meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filters.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && _selectedFilters[Filters.lactoseFree]!) {
        return false;
      }
      if (!meal.isVegan && _selectedFilters[Filters.vegan]!) {
        return false;
      }
      if (!meal.isVegetarian && _selectedFilters[Filters.vegetarian]!) {
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
