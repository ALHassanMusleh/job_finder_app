import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({super.key, required this.file});

  final File file;
  @override
  Widget build(BuildContext context) {
    final name = basename(file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume View'),
      ),
      body: PDFView(
        filePath: file.path,
      ),
    );
  }
}
