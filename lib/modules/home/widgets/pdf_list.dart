import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/core/utils/extension/ref.dart';
import 'package:pdf_reader/router/router.dart';
import 'package:pdf_reader/shared/widgets/pdf_list_tile.dart';

class PdfList extends ConsumerWidget {
  const PdfList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfLists = ref.select(homeProvider, (s) => s.categoryPdfs);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                'All PDFs',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: pdfLists.length,
          itemBuilder: (context, index) {
            final pdf = pdfLists[index];
            return PdfListTile(
              title: pdf.name ?? 'No Title',
              category: pdf.categoryName ?? 'Other',
              onTap: () {
                context.pushNamed(
                  Routes.pdfRead,
                  pathParameters: {'id': pdf.id.toString()},
                );
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ],
    );
  }
}
