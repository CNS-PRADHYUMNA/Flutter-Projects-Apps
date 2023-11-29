import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food/Providers/filters_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filters.glutenFree]!,
            onChanged: (ischeked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filters.glutenFree, ischeked);
            },
            title: Text(
              "Gluten-Free",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only Gluten-Free Meals.",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            contentPadding: EdgeInsets.only(left: 34, right: 32),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegan]!,
            onChanged: (ischeked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filters.vegan, ischeked);
            },
            title: Text(
              "Vegan",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only Vegan Meals.",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            contentPadding: EdgeInsets.only(left: 34, right: 32),
          ),
          SwitchListTile(
            value: activeFilters[Filters.lactoseFree]!,
            onChanged: (ischeked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filters.lactoseFree, ischeked);
            },
            title: Text(
              "Lactose-Free",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only Lactose-Free Meals.",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            contentPadding: EdgeInsets.only(left: 34, right: 32),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegetarien]!,
            onChanged: (ischeked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filters.vegetarien, ischeked);
            },
            title: Text(
              "Vegetarien",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only Vegetarien Meals.",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            contentPadding: EdgeInsets.only(left: 34, right: 32),
          ),
        ],
      ),
    );
  }
}
