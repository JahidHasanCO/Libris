import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:libris/modules/pdf_read/pdf_read.dart';
import 'package:libris/router/router.dart' show AsPathExt, Routes;

class PdfReadPage extends StatelessWidget {
  const PdfReadPage({required this.pdfId, super.key});

  final int pdfId;

  static final route = GoRoute(
    path: '${Routes.pdfRead.asPath}/:id',
    name: Routes.pdfRead,
    builder: (context, state) {
      final pdfId = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
      return PdfReadPage(pdfId: pdfId);
    },
  );

  @override
  Widget build(BuildContext context) {
    return PdfReadView(pdfId: pdfId);
  }
}
