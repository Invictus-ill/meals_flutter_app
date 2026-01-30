import 'package:flutter/material.dart';
import 'package:meals_flutter_app/models/meal.dart';
import 'package:meals_flutter_app/screens/meal_details.dart';
import 'package:meals_flutter_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
    required this.onToggleFavoriteMeal,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavoriteMeal;

  void _selectMeal(BuildContext ctx, Meal meal) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavoriteMeal: onToggleFavoriteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mealsScreenBody = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, int index) {
        return MealItem(meal: meals[index], onSelectMeal: _selectMeal);
      },
    );

    if (meals.isEmpty) {
      mealsScreenBody = Center(
        child: Text(
          'No meals available right now !',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      );
    }

    if (title == null) {
      return mealsScreenBody;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: mealsScreenBody,
    );
  }
}
