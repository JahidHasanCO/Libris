import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:pdf_reader/modules/pdf_theme/pdf_theme.dart';
import 'package:pdf_reader/router/router.dart' show AsPathExt, Routes;

class PdfThemePage extends StatelessWidget {
  const PdfThemePage({super.key});

  static final route = GoRoute(
    path: Routes.pdfTheme.asPath,
    name: Routes.pdfTheme,
    builder: (context, state) {
      return const PdfThemePage();
    },
  );

  @override
  Widget build(BuildContext context) {
    return const PdfThemeView();
  }
}
