import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_flutter_app/models/meal.dart';
import 'package:meals_flutter_app/providers/meals_provider.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier() : super(kInitialFilters);

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filters, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>((ref) {
      return FiltersNotifier();
    });

final availableMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

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

  return availableMeals;
});
