import 'package:flutter_riverpod/legacy.dart';

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

final FiltersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>((ref) {
      return FiltersNotifier();
    });
