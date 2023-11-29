import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food/models/meal.dart';

class FavsMealNotifier extends StateNotifier<List<Meal>> {
  FavsMealNotifier() : super([]);

  bool toggleFavs(Meal meal) {
    final mealFav = state.contains(meal);
    if (mealFav) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favsMealProvider = StateNotifierProvider<FavsMealNotifier, List<Meal>>(
    (ref) => FavsMealNotifier());
