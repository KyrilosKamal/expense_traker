import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/expenses_model.dart';

class ExpensesChartScreen extends StatelessWidget {
  const ExpensesChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<Expenses> expenseBox = Hive.box<Expenses>('expenses');

    Map<ExpenseType, double> totals = {};
    for (var e in expenseBox.values) {
      totals[e.category] = (totals[e.category] ?? 0) + e.money;
    }

    final sections = totals.entries.map((entry) {
      return PieChartSectionData(
        color: _getColor(entry.key),
        value: entry.value,
        title: '${entry.key.name}\n ${entry.value.toStringAsFixed(1)} ُEGP',
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Distribution")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: sections.isEmpty
            ? const Center(child: Text("No expenses to display."))
            : PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 50,
                  sectionsSpace: 2,
                ),
              ),
      ),
    );
  }

  Color _getColor(ExpenseType type) {
    switch (type) {
      case ExpenseType.Food:
        return Colors.blue;
      case ExpenseType.Transport:
        return Colors.orange;
      case ExpenseType.Shopping:
        return Colors.purple;
      case ExpenseType.Bills:
        return Colors.green;
      case ExpenseType.Other:
        return Colors.grey;
    }
  }
}
