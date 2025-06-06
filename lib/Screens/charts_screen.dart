import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../PdfExporter.dart';
import '../models/expenses_model.dart';

class ExpensesChartScreen extends StatefulWidget {
  const ExpensesChartScreen({super.key});

  @override
  State<ExpensesChartScreen> createState() => _ExpensesChartScreenState();
}

class _ExpensesChartScreenState extends State<ExpensesChartScreen> {
  final GlobalKey chartKey = GlobalKey();

  Future<Uint8List?> captureChartImage() async {
    try {
      RenderRepaintBoundary boundary =
      chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing chart image: $e');
      return null;
    }
  }

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
        title: '${entry.key.name}\n${entry.value.toStringAsFixed(1)} EGP',
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }).toList();

    // تجهيز بيانات التقرير كقائمة
    List<Map<String, dynamic>> expensesData = totals.entries
        .map((e) => {'category': e.key.name, 'amount': e.value})
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Distribution")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: sections.isEmpty
            ? const Center(child: Text("No expenses to display."))
            : RepaintBoundary(
          key: chartKey,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 50,
              sectionsSpace: 2,
            ),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            debugPrint('Export button pressed');
            Uint8List? chartImage = await captureChartImage();
            if (chartImage != null) {
              debugPrint('Chart image captured, exporting PDF...');
              await PdfExporter.exportExpensesWithChart(
                expensesData: expensesData,
                chartImageBytes: chartImage,
              );
              debugPrint('PDF export finished');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('An error occurred capturing chart image')),
              );
            }
          },
          child: const Icon(Icons.picture_as_pdf),
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
