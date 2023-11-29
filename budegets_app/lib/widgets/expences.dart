import 'package:budegets_app/models/expence.dart';
import 'package:budegets_app/widgets/chart/chart.dart';
import 'package:budegets_app/widgets/expence_list/expences_list.dart';
import 'package:budegets_app/widgets/new_expences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final List<Expence> _registeredExpences = [
    Expence(
        title: "title",
        amount: 99.99,
        date: DateTime.now(),
        category: Category.travel)
  ];

  void _modelsheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => NewExpence(
              onAddExpence: addExpence,
            ));
  }

  void addExpence(Expence exp) {
    setState(() {
      _registeredExpences.add(exp);
    });
  }

  void removeExpence(Expence exp) {
    final idx = _registeredExpences.indexOf(exp);

    setState(() {
      _registeredExpences.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expence Deleted !!",
            style: GoogleFonts.alegreya(
              color: Colors.white,
              fontSize: 18,
            )),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () => setState(
            () {
              _registeredExpences.insert(idx, exp);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget x = Center(
      child: Text(
        "No Expences added !!",
        style: GoogleFonts.alegreya(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _modelsheet,
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 0, 208, 255),
        title: Text(
          "BUDGET PLANNER ",
          style: GoogleFonts.alegreya(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpences),
                Expanded(
                    child: _registeredExpences.isNotEmpty
                        ? ExpenceList(
                            expences: _registeredExpences,
                            onRemoved: removeExpence,
                          )
                        : x)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpences)),
                Expanded(
                    child: _registeredExpences.isNotEmpty
                        ? ExpenceList(
                            expences: _registeredExpences,
                            onRemoved: removeExpence,
                          )
                        : x)
              ],
            ),
    );
  }
}
