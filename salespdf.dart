

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'sqldb.dart'; // Import your SqlDb class

class PdfGenerator {
  final pdf = pw.Document();
  final SqlDb sqlDb = SqlDb();

  Future<void> writeOnPdf() async {
    // Load custom Arabic font
    var arabicFont = pw.Font.ttf(await rootBundle.load("fonts/HacenTunisia.ttf"));

    // Retrieve data from the 'sales' table
    List<Map<String, dynamic>> salesData = await sqlDb.readData('SELECT * FROM sales');

    // Add data to the PDF
    pdf.addPage(pw.MultiPage(
      theme: pw.ThemeData.withFont(base: arabicFont),
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text('تقرير المبيعات', textScaleFactor: 2)),
          pw.TableHelper.fromTextArray(
            context: context,
            headers: <String>['رقم', 'الاسم', 'التاريخ', 'عدد', 'وزن', 'سعر الكيلو', 'المجموع', 'المبالغ المدفوعة'],
            data: salesData.map((row) {
              return [
                row['id'].toString(),
                row['nom'] ?? '',
                row['date'] ?? '',
                row['nbr']?.toString() ?? '',
                row['poid']?.toString() ?? '',
                row['onekg']?.toString() ?? '',
                row['some']?.toString() ?? '',
                row['vers']?.toString() ?? '',
              ];
            }).toList(),
          ),
        ];
      },
    ));
  }

  Future<void> savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/sales_report.pdf");

    Uint8List pdfData = await pdf.save();

    await file.writeAsBytes(pdfData);
  }
}