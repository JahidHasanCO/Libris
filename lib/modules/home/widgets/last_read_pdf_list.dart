import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/core/utils/extension/ref.dart';
import 'package:pdf_reader/modules/home/home.dart';
import 'package:pdf_reader/router/router.dart';

class LastReadPdfList extends ConsumerWidget {
  const LastReadPdfList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfLists = ref.select(homeProvider, (s) => s.lastReadPdfs);
    if (pdfLists.isEmpty) return const SizedBox();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Text(
                'Continue Reading',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 180,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: pdfLists.length,
            itemBuilder: (context, index) {
              final pdf = pdfLists[index];
              return ContinuePdfCard(
                title: pdf.name ?? 'No Title',
                subtitle: pdf.categoryName ?? 'Other',
                totalPages: pdf.totalPages ?? 0,
                currentPage: pdf.currentPage,
                onTap: () {
                  context.pushNamed(
                    Routes.pdfRead,
                    pathParameters: {'id': pdf.id.toString()},
                  );
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }
}
