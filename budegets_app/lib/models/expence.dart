import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();

final formatter = DateFormat.yMMMd();

enum Category { food, travel, work, shopping }

const categoryIcons = {
  Category.food: (Icons.fastfood_sharp),
  Category.travel: (Icons.flight_takeoff),
  Category.shopping: (Icons.shopping_cart),
  Category.work: (Icons.work_outlined),
};

class Expence {
  Expence(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenceBucket {
  const ExpenceBucket({required this.cat, required this.exps});

  ExpenceBucket.forCatergory(List<Expence> allExpence, this.cat)
      : exps = allExpence.where((x) => x.category == cat).toList();

  final Category cat;
  final List<Expence> exps;

  double get totalSum {
    double s = 0;

    for (final i in exps) {
      s += i.amount;
    }
    return s;
  }
}
