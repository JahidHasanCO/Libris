import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/shared/enums/menu.dart';
import 'package:libris/shared/widgets/pop_up_menu_button.dart';

class PdfGridTile extends StatelessWidget {
  const PdfGridTile({
    required this.title,
    required this.category,
    required this.menuItems,
    this.onMenuSelected,
    this.totalPages = 0,
    this.currentPage = 0,
    super.key,
    this.onTap,
  });

  final String title;
  final String category;
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
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: greyLightColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Icon(
                      Symbols.picture_as_pdf,
                      color: greyColor,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: textColorLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (totalPages > 0)
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      color: primaryColor,
                      backgroundColor: greyLightColor.withValues(alpha: 0.2),
                    ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: PopupAppMenuButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
