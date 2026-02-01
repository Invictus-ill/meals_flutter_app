import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_flutter_app/models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  bool onToggleFavoriteMeal(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
      return FavoritesNotifier();
    });
