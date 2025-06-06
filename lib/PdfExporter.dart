import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfExporter {
  static Future<void> exportExpensesWithChart({
    required List<Map<String, dynamic>> expensesData,
    required Uint8List chartImageBytes,
  }) async {
    final pdf = pw.Document();

    final chartImage = pw.MemoryImage(chartImageBytes);

    const itemsPerPage = 20; // عدد البنود في كل صفحة

    int totalPages = (expensesData.length / itemsPerPage).ceil();

    for (int page = 0; page < totalPages; page++) {
      final start = page * itemsPerPage;
      final end = (start + itemsPerPage) > expensesData.length
          ? expensesData.length
          : (start + itemsPerPage);

      final pageItems = expensesData.sublist(start, end);

      final expenseWidgets = pageItems.map((item) {
        return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Text(
            '${item['category']} : ${item['amount'].toStringAsFixed(2)} EGP',
            style: const pw.TextStyle(fontSize: 14),
          ),
        );
      }).toList();

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (page == 0)
                  pw.Text('Expenses Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                if (page == 0) pw.SizedBox(height: 20),
                pw.Text('Expenses Details:', style: const pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 10),
                ...expenseWidgets,
                if (page == totalPages - 1) ...[
                  pw.SizedBox(height: 30),
                  pw.Text('Chart:', style: const pw.TextStyle(fontSize: 18)),
                  pw.SizedBox(height: 10),
                  pw.Center(
                    child: pw.Container(
                      width: 300,
                      height: 300,
                      child: pw.Image(chartImage, fit: pw.BoxFit.contain),
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
