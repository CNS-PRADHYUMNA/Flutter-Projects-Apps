import 'package:flutter/material.dart';
import 'package:food/Widgets/categorygriditem.dart';
import 'package:food/data/dummy_data.dart';
import 'package:food/models/category.dart';
import 'package:food/models/meal.dart';

import 'package:food/screens/meals.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meal: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(22),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (final x in availableCategories)
              CategoryGridItem(
                category: x,
                onTapped: () {
                  _selectCategory(context, x);
                },
              ),
          ],
        ),
        builder: (context, child) => FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOut)),
              child: child,
            ));
  }
}
