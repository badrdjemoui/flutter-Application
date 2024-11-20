import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'sqldb.dart'; // Import your SqlDb class

class PdfGenerator {
  late final pw.Document pdf; // PDF document instance
  final SqlDb sqlDb = SqlDb(); // Instance of custom database class

  // Constructor to initialize the PDF document
  PdfGenerator() {
    pdf = pw.Document(); // Initialize the PDF document
  }

  // Method to write content into the PDF
  Future<void> writeOnPdf() async {
    // Load the custom Arabic font from assets
    var arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri.ttf"));

    // Retrieve sales data from the 'sales' table in the database
    List<Map<String, dynamic>> salesData = await sqlDb.readData('SELECT * FROM sales');

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: arabicFont, // Apply the Arabic font globally
        ),
        pageFormat: PdfPageFormat.a4, // Set the page size to A4
        margin: const pw.EdgeInsets.all(32), // Set page margins to 32 points
        build: (pw.Context context) {
          return <pw.Widget>[
            // Header: Centered text with Arabic font and RTL text direction
            pw.Directionality(
              textDirection: pw.TextDirection.rtl, // Set the text direction to right-to-left
              child: pw.Align(
                alignment: pw.Alignment.center, // Center the header text horizontally
                child: pw.Header(
                  level: 0, // First-level header
                  child: pw.Text(
                    'تقرير المبيعات', // Arabic text for "Sales Report"
                    style: pw.TextStyle(font: arabicFont, fontSize: 24), // Styling the header
                    textAlign: pw.TextAlign.center, // Align the text in the center
                  ),
                ),
              ),
            ),
            // Table: Centered table to display the sales data, with RTL text direction for the table
            pw.Directionality(
              textDirection: pw.TextDirection.rtl, // Set the text direction to right-to-left
              child: pw.Align(
                alignment: pw.Alignment.center, // Center the table horizontally
                child: pw.Table(
                  border: pw.TableBorder.all(), // Add borders to the table cells
                  children: [
                    // Table Header Row: Column names
                    pw.TableRow(
                      children: [
                        pw.Text('رقم', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                        pw.Text('الاسم', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                        pw.Text('التاريخ', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                        pw.Text('عدد', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                        pw.Text('وزن', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                        pw.Text('سعر الكيلو', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                        pw.Text('المجموع', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                        pw.Text('المبالغ المدفوعة', style: pw.TextStyle(font: arabicFont, fontSize: 12), textAlign: pw.TextAlign.center),
                      ],
                    ),
                    // Data Rows: Dynamically populated rows from salesData
                    ...salesData.map((row) {
                      return pw.TableRow(
                        children: [
                          pw.Text(row['id'].toString(), style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                          pw.Text(row['nom'] ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                          pw.Text(row['date'] ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                          pw.Text(row['nbr']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                          pw.Text(row['poid']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                          pw.Text(row['onekg']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                          pw.Text(row['some']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                          pw.Text(row['vers']?.toString() ?? '', style: pw.TextStyle(font: arabicFont, fontSize: 10), textAlign: pw.TextAlign.center),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
  }

  // Method to save the PDF to the device and open it
  Future<void> savePdf() async {
    // Retrieve the document directory where we can save the PDF
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    
    // Create a file where the PDF will be saved
    File file = File("$documentPath/sales_report.pdf");

    // Convert the PDF document to a byte array and save it
    Uint8List pdfData = await pdf.save();
    await file.writeAsBytes(pdfData);

    // Print the location where the PDF is saved
    print("PDF saved to $documentPath/sales_report.pdf");

    // Open the saved PDF file using the default file viewer
    OpenFilex.open(file.path);
  }
}
