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
  @override
  Widget build(BuildContext context) {
    final List<Expense> expenses = userExpenses;

    return Scaffold(
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
