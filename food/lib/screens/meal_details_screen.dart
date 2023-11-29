import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food/Providers/favs.dart';
import 'package:food/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favMeals = ref.watch(favsMealProvider);
    final check = favMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded =
                  ref.read(favsMealProvider.notifier).toggleFavs(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(
                    wasAdded ? "Item Addded 😋" : "Item Removed 🤢",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )));
            },
            icon: AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              duration: const Duration(milliseconds: 750),
              child: check
                  ? Icon(
                      key: ValueKey(check),
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Ingredients ",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.amber,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            for (final i in meal.ingredients)
              Text(
                i,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
              ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Steps ",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.amber,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            for (final i in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  i,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
