import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/core/utils/extension/string.dart';
import 'package:libris/modules/pdf_entry/pdf_entry.dart';
import 'package:libris/router/router.dart';
import 'package:libris/shared/enums/menu.dart';
import 'package:libris/shared/models/models.dart';
import 'package:libris/shared/widgets/pdf_list_tile.dart';
import 'package:libris/shared/widgets/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

class PdfList extends ConsumerWidget {
  const PdfList({super.key});

  static List<Menu> filterMenus = [
    Menu.edit,
    Menu.delete,
    Menu.moveToPrivate,
    Menu.removeFromShelf,
  ];

  Future<void> onMenuSelected(WidgetRef ref, int index, PDF pdf) async {
    if (filterMenus[index] == Menu.edit) {
      await PdfEntryBottomSheet.show(ref.context, isUpdate: true, entry: pdf);
      if (!ref.context.mounted) return;
      await ref.read(shelveDetailsProvider.notifier).onRefresh();
    }
    if (filterMenus[index] == Menu.delete) {
      if (!ref.context.mounted) return;
      await ref.read(shelveDetailsProvider.notifier).deletePdf(pdf.id ?? 0);
    } else if (filterMenus[index] == Menu.moveToPrivate) {
      if (!ref.context.mounted) return;
      await ref.read(shelveDetailsProvider.notifier).moveToPrivate(pdf.id ?? 0);
    } else if (filterMenus[index] == Menu.removeFromShelf) {
      if (!ref.context.mounted) return;
      await ref
          .read(shelveDetailsProvider.notifier)
          .removePdfFromShelf(pdf.id ?? 0);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfLists = ref.select(shelveDetailsProvider, (s) => s.pdfList);
    final viewType = ref.select(shelveDetailsProvider, (s) => s.pdfViewType);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                onTap: () => ref
                    .read(shelveDetailsProvider.notifier)
                    .changePdfViewType(0),
                child: Icon(
                  Symbols.list,
                  color: viewType == 0 ? primaryColor : greyLightColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  ref.read(shelveDetailsProvider.notifier).changePdfViewType(1);
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
                category: pdf.createdAt?.toDdMmYy() ?? 'Other',
                totalPages: pdf.totalPages ?? 0,
                currentPage: pdf.currentPage,
                menuItems: filterMenus,
                onTap: () {
                  context.pushNamed(
                    Routes.pdfRead,
                    pathParameters: {'id': pdf.id.toString()},
                  );
                },
                onMenuSelected: (index) => onMenuSelected(ref, index, pdf),
              );
            },
          ),

        if (viewType == 0)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: pdfLists.length,
            itemBuilder: (context, index) {
              final pdf = pdfLists[index];
              return PdfListTile(
                title: pdf.name ?? 'No Title',
                subtitle: pdf.createdAt?.toDdMmYy() ?? 'Other',
                totalPages: pdf.totalPages ?? 0,
                currentPage: pdf.currentPage,
                menuItems: filterMenus,
                onTap: () {
                  context.pushNamed(
                    Routes.pdfRead,
                    pathParameters: {'id': pdf.id.toString()},
                  );
                },
                onMenuSelected: (index) => onMenuSelected(ref, index, pdf),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
      ],
    );
  }
}
