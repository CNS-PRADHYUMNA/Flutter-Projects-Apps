import 'package:budegets_app/models/expence.dart';
import 'package:flutter/material.dart';

class ExpenceItem extends StatelessWidget {
  const ExpenceItem({required this.a, super.key});

  final Expence a;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              a.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(' ₹ ${a.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[a.category]),
                    const SizedBox(
                      width: 9,
                    ),
                    Text(a.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
