import 'package:book_app/components/app_button.dart';
import 'package:book_app/notifiers/app_notifier.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({
    super.key,
    this.nameBook,
    this.linkPdfBook,
  });

  final String? nameBook;
  final String? linkPdfBook;

  @override
  Widget build(BuildContext context) {
    String uri =
        "https://books.googleusercontent.com/books/content?req=AKW5Qaf0ECRFIP1doYH9mZSxPMFZmFroJhLWm-uofPS9ScRBRJRPrYA-lCaUBRmj6Du5Kpce6veTviamR3ZEQ_XcLH09YzgKjWHi53qdmmIvih5hk67iduZI6fIlAeKRHTwdOHr3gEFvSo-R5ThelPbtG4FFfYYUn9TQ3cn3uuufni48crG06oTochcp3u3Szm8meDbwNRnt65t6ZmCw6tzRycp5jsT_oCu4wZ_ipNYrOsQ824nfPZPuMw2KL__LbBqyCC6bmgmQuGPdPAWVLZURbp9w2De3Sw";
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(nameBook ?? "No Name"),
      ),
      body: Consumer<AppNotifier>(builder: (context, value, child) {
        return linkPdfBook != null
            ? PDFView(
                filePath: value.filePath,
                enableSwipe: true, 
                swipeHorizontal: true, 
                autoSpacing: true, 
                pageSnap: true, 
                onPageChanged: (int? page, int? total) {
                  print('Trang: $page/$total');
                },
              )
            : Center(
                child: AppButton(
                  text: "Download PDF",
                  onTap: () {
                    value.getPDFBook(uri: uri);
                  },
                ),
              );
      }),
    );
  }
}
