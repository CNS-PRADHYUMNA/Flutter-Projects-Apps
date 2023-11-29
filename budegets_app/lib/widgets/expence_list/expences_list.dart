import 'package:budegets_app/widgets/expence_list/expence_item.dart';
import 'package:flutter/material.dart';
import 'package:budegets_app/models/expence.dart';

class ExpenceList extends StatelessWidget {
  const ExpenceList(
      {super.key, required this.expences, required this.onRemoved});
  final void Function(Expence exp) onRemoved;

  final List<Expence> expences;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expences.length,
        itemBuilder: (context, index) => Dismissible(
            background: Container(
              color: Colors.redAccent,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onDismissed: (direction) {
              onRemoved(expences[index]);
            },
            key: ValueKey(expences[index]),
            child: ExpenceItem(a: expences[index])));
  }
}
