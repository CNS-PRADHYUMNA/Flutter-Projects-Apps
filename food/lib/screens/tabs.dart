import 'package:flutter/material.dart';
import 'package:food/Widgets/sidedrawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food/Providers/favs.dart';
import 'package:food/Providers/filters_provider.dart';
import 'package:food/screens/categories.dart';
import 'package:food/screens/filters.dart';
import 'package:food/screens/meals.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarien: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectedPage(int i) {
    setState(() {
      _selectedPageIndex = i;
    });
  }

  void _setScreen(String str) async {
    Navigator.of(context).pop();
    if (str == "filters") {
      await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: ((context) => const FilterScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activescreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    if (_selectedPageIndex == 1) {
      final favMeals = ref.watch(favsMealProvider);
      activescreen = MealsScreen(meal: favMeals);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPageIndex == 0 ? "Categories" : "Your Specials"),
      ),
      drawer: MainDrawer(onSlectScreen: _setScreen),
      body: activescreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_sharp), label: "Special"),
        ],
      ),
    );
  }
}
