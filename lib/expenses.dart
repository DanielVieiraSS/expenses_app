import 'package:expenses_app/data/user_expenses.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const Text("Testando"));
  }

  @override
  Widget build(BuildContext context) {
    final List<Expense> expenses = userExpenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter expense tracker"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(
              expenses: expenses,
            ),
          ),
        ],
      ),
    );
  }
}
