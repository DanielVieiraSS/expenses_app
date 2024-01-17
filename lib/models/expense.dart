import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Categoria {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Categoria.food: Icons.lunch_dining,
  Categoria.travel: Icons.flight_takeoff,
  Categoria.leisure: Icons.movie,
  Categoria.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categoria category;

  String get formattedDate {
    return formatter.format(date);
  }
}
