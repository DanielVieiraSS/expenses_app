import 'package:flutter/material.dart';

import 'package:expenses_app/models/expense.dart';
import 'package:flutter/rendering.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final expenseTitleController = TextEditingController();
  final expenseAmountController = TextEditingController();
  DateTime? selectedDate;
  Categoria selectedCategory = Categoria.leisure;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(expenseAmountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (expenseTitleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: expenseTitleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    expenseTitleController.dispose();
    expenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16 + keyboardSpace, 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: expenseTitleController,
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
                          keyboardType: TextInputType.number,
                          controller: expenseAmountController,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: expenseTitleController,
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
                          items: Categoria.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase().toString(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
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
                            Text(
                              selectedDate == null
                                  ? "No date selected"
                                  : formatter.format(selectedDate!),
                            ),
                            IconButton(
                              onPressed: presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: expenseAmountController,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text("Amount"),
                          ),
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
                            Text(
                              selectedDate == null
                                  ? "No date selected"
                                  : formatter.format(selectedDate!),
                            ),
                            IconButton(
                              onPressed: presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 16),
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
                        onPressed: submitExpenseData,
                        child: const Text("Save Expense"),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: selectedCategory,
                          items: Categoria.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase().toString(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
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
                        onPressed: submitExpenseData,
                        child: const Text("Save Expense"),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
