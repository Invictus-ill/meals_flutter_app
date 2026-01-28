import 'package:flutter/material.dart';
import 'package:meals_flutter_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;

  @override
  Widget build(ctx) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(ctx).colorScheme.onPrimaryContainer,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color.withOpacity(0.9),
            ],
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(ctx).textTheme.titleLarge!.copyWith(
            color: Theme.of(ctx).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
