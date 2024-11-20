import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'sqldb.dart'; // Import your SqlDb class

class PdfGenerator {
  late final pw.Document pdf;
  final SqlDb sqlDb = SqlDb();

  PdfGenerator() {
    pdf = pw.Document();
  }

  Future<void> writeOnPdf() async {
    // Load the custom Arabic font
    var arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri.ttf"));

    // Retrieve data from the 'sales' table
    List<Map<String, dynamic>> salesData = await sqlDb.readData('SELECT * FROM sales');

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            // Header
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Header(
                level: 0,
                child: pw.Text(
                  'تقرير المبيعات',
                  style: pw.TextStyle(font: arabicFont, fontSize: 24),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ),
            // Table
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Header Row
                  pw.TableRow(
                    children: [
                      pw.Text('رقم', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.Text('الاسم', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.Text('التاريخ', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.Text('عدد', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.Text('وزن', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.Text('سعر الكيلو', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.Text('المجموع', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.Text('المبالغ المدفوعة', style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                    ],
                  ),
                  // Data Rows
                  ...salesData.map((row) {
                    return pw.TableRow(
                      children: [
                        pw.Text(row['id'].toString(), style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                        pw.Text(row['nom'] ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                        pw.Text(row['date'] ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                        pw.Text(row['nbr']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                        pw.Text(row['poid']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                        pw.Text(row['onekg']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                        pw.Text(row['some']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                        pw.Text(row['vers']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }

  Future<void> savePdf() async {
    // Save the PDF document and open it
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/sales_report.pdf");

    Uint8List pdfData = await pdf.save();
    await file.writeAsBytes(pdfData);

    print("PDF saved to $documentPath/sales_report.pdf");

    // Open the PDF using a file viewer
    OpenFilex.open(file.path);
  }
}
