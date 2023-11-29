import 'package:flutter/material.dart';
import 'package:budegets_app/models/expence.dart';

class NewExpence extends StatefulWidget {
  const NewExpence({super.key, required this.onAddExpence});

  final void Function(Expence exp) onAddExpence;

  @override
  State<NewExpence> createState() => _NewExpenceState();
}

class _NewExpenceState extends State<NewExpence> {
  final titleController = TextEditingController();
  final amtController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    amtController.dispose();
    super.dispose();
  }

  DateTime? selectedDate;
  Category selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final myDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      selectedDate = myDate;
    });
  }

  void _saveExpenceData() {
    final amt = double.tryParse(amtController.text);

    if ((titleController.text.trim().isEmpty) ||
        (amt == null || amt <= 0) ||
        (selectedDate == null)) {
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text(
                "Invalid Input",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text(
                "Please make sure you have entered the date,title,amount...",
                style: TextStyle(fontSize: 17),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Okay"))
              ],
            )),
      );
      return;
    }
    widget.onAddExpence(Expence(
        title: titleController.text,
        amount: amt,
        date: selectedDate!,
        category: selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final xyz = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (p0, p1) {
        final width = p1.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, 16 + xyz),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: TextField(
                            controller: amtController,
                            maxLength: 6,
                            decoration: const InputDecoration(
                                label: Text("Amount"), prefixText: '₹'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = value;
                              });
                            }),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(selectedDate == null
                                  ? "No Date Selected"
                                  : formatter.format(selectedDate!)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: amtController,
                            maxLength: 6,
                            decoration: const InputDecoration(
                                label: Text("Amount"), prefixText: '₹'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(selectedDate == null
                                  ? "No Date Selected"
                                  : formatter.format(selectedDate!)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                          onPressed: _saveExpenceData,
                          child: const Text("Save Expence"),
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = value;
                              });
                            }),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                          onPressed: _saveExpenceData,
                          child: const Text("Save Expence"),
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
