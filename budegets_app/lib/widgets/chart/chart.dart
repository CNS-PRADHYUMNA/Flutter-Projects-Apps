import 'package:flutter/material.dart';

import './charbar.dart';
import 'package:budegets_app/models/expence.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expence> expenses;

  List<ExpenceBucket> get buckets {
    return [
      ExpenceBucket.forCatergory(expenses, Category.food),
      ExpenceBucket.forCatergory(expenses, Category.shopping),
      ExpenceBucket.forCatergory(expenses, Category.travel),
      ExpenceBucket.forCatergory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalSum > maxTotalExpense) {
        maxTotalExpense = bucket.totalSum;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalSum == 0
                        ? 0
                        : bucket.totalSum / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.cat],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
