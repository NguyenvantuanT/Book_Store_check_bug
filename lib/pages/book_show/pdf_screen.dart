import 'package:book_app/components/app_button.dart';
import 'package:book_app/notifiers/app_pdf_notifier.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key, this.name});
  final String? name;
  @override
  Widget build(BuildContext context) {
    String pdfUrl =
        "https://books.googleusercontent.com/books/content?req=AKW5QadUMAi33KignSUr_96jr7aH6j6lTdgEGqDowCjlA7WdZBLqYWeG2e_pGcqL_R9fVq1TWeqUwuwt1t5UpFoGzrV1PxpL9Dc3A4CQiUdD8gnhPu4vIj3j5Fbg7lefSw_t5gUX3-EBKXOIciAlEeacbBIkfcwMO77bOB--yQ_raFZgZNfdgXNw1tdeP-XmN6VZScVlIpB5wuXNZwhUdPMGqGMxqOwRlE-QJ74SNVYcFX4m8g6p7GmrM2KEwRQUvAGe4M-WPl8p4QWkuMLEvd3wzUzYs79oSg";
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: Text(
            name ?? "PDF Viewer",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Consumer<AppPdfNotifier>(
          builder: (context, value, child) {
            return value.filePath != null
                ? Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: PDFView(
                          filePath: value.filePath,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: true,
                          pageSnap: true,
                          onPageChanged: (int? page, int? total) {
                            value.getPage(total, page);
                          },
                        ),
                      ),
                      Positioned(
                        right: 40.0,
                        bottom: 40.0,
                        child: Row(
                          children: [
                            Text("${value.page}/${value.total}"),
                          ],
                        ),
                      )
                    ],
                  )
                : AppButton(
                    text: "Download Book PDF",
                    onTap: () async {
                      await value.downloadPDF(pdfUrl);
                    },
                  );
          },
        ));
  }
}
