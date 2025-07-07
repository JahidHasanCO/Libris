import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/router/router.dart';
import 'package:libris/shared/enums/menu.dart';
import 'package:libris/shared/widgets/pdf_list_tile.dart';
import 'package:libris/shared/widgets/widgets.dart';

class PdfList extends ConsumerWidget {
  const PdfList({super.key});

  static List<Menu> filterMenus = [
    Menu.edit,
    Menu.delete,
    Menu.moveToPrivate,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfLists = ref.select(homeProvider, (s) => s.categoryPdfs);
    final viewType = ref.select(homeProvider, (s) => s.pdfViewType);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'All PDFs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ref.read(homeProvider.notifier).changePdfViewType(0);
                },
                child: Icon(
                  Symbols.list,
                  color: viewType == 0 ? primaryColor : greyLightColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  ref.read(homeProvider.notifier).changePdfViewType(1);
                },
                child: Icon(
                  Symbols.grid_view,
                  color: viewType == 1 ? primaryColor : greyLightColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),

        if (viewType == 1)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: pdfLists.length,
            itemBuilder: (context, index) {
              final pdf = pdfLists[index];
              return PdfGridTile(
                title: pdf.name ?? '',
                category: pdf.categoryName ?? 'Other',
                totalPages: pdf.totalPages ?? 0,
                currentPage: pdf.currentPage,
                menuItems: filterMenus,
                onTap: () {
                  context.pushNamed(
                    Routes.pdfRead,
                    pathParameters: {'id': pdf.id.toString()},
                  );
                },
                onMenuSelected: (index) {
                  if (filterMenus[index] == Menu.delete) {
                    ref.read(homeProvider.notifier).deletePdf(pdf.id);
                  } else if (filterMenus[index] == Menu.moveToPrivate) {
                    ref.read(homeProvider.notifier).moveToPrivate(pdf.id);
                  }
                },
              );
            },
          ),

        if (viewType == 0)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: pdfLists.length,
            itemBuilder: (context, index) {
              final pdf = pdfLists[index];
              return PdfListTile(
                title: pdf.name ?? 'No Title',
                subtitle: pdf.categoryName ?? 'Other',
                totalPages: pdf.totalPages ?? 0,
                currentPage: pdf.currentPage,
                menuItems: filterMenus,
                onTap: () {
                  context.pushNamed(
                    Routes.pdfRead,
                    pathParameters: {'id': pdf.id.toString()},
                  );
                },
                onMenuSelected: (index) {
                  if (filterMenus[index] == Menu.delete) {
                    ref.read(homeProvider.notifier).deletePdf(pdf.id);
                  } else if (filterMenus[index] == Menu.moveToPrivate) {
                    ref.read(homeProvider.notifier).moveToPrivate(pdf.id);
                  }
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
      ],
    );
  }
}
