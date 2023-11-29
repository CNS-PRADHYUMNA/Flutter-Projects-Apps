import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food/data/dummy_data.dart';

enum Filters {
  vegan,
  glutenFree,
  lactoseFree,
  vegetarien,
}

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.vegan: false,
          Filters.vegetarien: false,
          Filters.lactoseFree: false,
        });
  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filters, bool> choosenFilters) {
    state = choosenFilters;
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filters, bool>>(
        (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  return dummyMeals.where((meal) {
    final selectedFilters = ref.watch(filterProvider);
    if (selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (selectedFilters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }
    if (selectedFilters[Filters.vegetarien]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
