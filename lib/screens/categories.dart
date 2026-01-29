import 'package:flutter/material.dart';
import 'package:meals_flutter_app/data/dummy_data.dart';
import 'package:meals_flutter_app/models/category.dart';
import 'package:meals_flutter_app/screens/meals.dart';
import 'package:meals_flutter_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category selectedCategory) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          meals: dummyMeals
              .where(
                (element) => element.categories.contains(selectedCategory.id),
              )
              .toList(),
          title: selectedCategory.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: [
        for (final Category category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
