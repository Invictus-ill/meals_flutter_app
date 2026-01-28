import 'package:flutter/material.dart';
import 'package:meals_flutter_app/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            meal.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            ),
          ),
          Image.network(meal.imageUrl),
        ],
      ),
    );
  }
}
