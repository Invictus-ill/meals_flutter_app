import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_flutter_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filters.glutenFree]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-Free',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 24,
              ),
            ),
            subtitle: Text('Toggle for gluten-free options'),
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filters.lactoseFree]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-Free',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 24,
              ),
            ),
            subtitle: Text('Toggle for lactose-free options'),
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegetarian]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 24,
              ),
            ),
            subtitle: Text('Toggle for vegetarian options'),
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegan]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 24,
              ),
            ),
            subtitle: Text('Toggle for vegan options'),
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
