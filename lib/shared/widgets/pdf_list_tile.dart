import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/shared/enums/menu.dart';
import 'package:pdf_reader/shared/widgets/widgets.dart';

class PdfListTile extends StatelessWidget {
  const PdfListTile({
    required this.title,
    required this.subtitle,
    required this.menuItems,
    this.totalPages = 0,
    this.currentPage = 0,
    this.onMenuSelected,
    super.key,
    this.onTap,
  });
  final String title;
  final String subtitle;
  final List<Menu> menuItems;
  final void Function(int index)? onMenuSelected;
  final VoidCallback? onTap;
  final int totalPages;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final progress = totalPages > 0 ? currentPage / totalPages : 0.0;
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Symbols.picture_as_pdf,
                  color: greyColor,
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              tileColor: greyLightColor.withValues(alpha: 0.3),
              title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
              subtitle: Text(subtitle),
              titleTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
              subtitleTextStyle: const TextStyle(
                fontSize: 14,
                color: textColorLight,
              ),
              onTap: onTap,
              trailing: PopupAppMenuButton(
                menus: menuItems,
                onSelected: (int index) {
                  if (onMenuSelected != null) {
                    onMenuSelected?.call(index);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Symbols.more_vert,
                    color: textColor,
                    size: 24,
                  ),
                ),
              ),
            ),
            if (totalPages > 0)
              LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                color: primaryColor,
                backgroundColor: greyLightColor.withValues(alpha: 0.2),
              ),
          ],
        ),
      ),
    );
  }
}
