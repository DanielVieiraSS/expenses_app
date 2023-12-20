import 'package:expenses_app/models/expense.dart';

List<Expense> userExpenses = [
  Expense(
    title: "FlutterCourse",
    amount: 19.99,
    date: DateTime.now(),
    category: Category.work,
  ),
  Expense(
    title: "Cinema",
    amount: 15.69,
    date: DateTime.now(),
    category: Category.leisure,
  )
];
