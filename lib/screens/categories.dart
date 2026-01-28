import 'package:flutter/material.dart';
import 'package:meals_flutter_app/data/dummy_data.dart';
import 'package:meals_flutter_app/models/category.dart';
import 'package:meals_flutter_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick your Category')),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: [
          for (final Category category in availableCategories)
            CategoryGridItem(category: category),
        ],
      ),
    );
  }
}
