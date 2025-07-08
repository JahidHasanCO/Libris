import 'package:flutter/material.dart';
import 'package:libris/core/theme/colors.dart'; // adjust if needed
import 'package:libris/shared/enums/menu.dart';
import 'package:libris/shared/widgets/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

class ShelveCard extends StatelessWidget {
  const ShelveCard({
    required this.title,
    required this.menuItems,
    this.onTap,
    this.onMenuSelected,
    super.key,
  });

  final String title;
  final VoidCallback? onTap;
  final List<Menu> menuItems;
  final void Function(int index)? onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: greyLightColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Symbols.folder,
                      color: primaryColor,
                      size: 24,
                    ),
                    const SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: PopupAppMenuButton(
                  menus: menuItems,
                  onSelected: (int index) {
                    if (onMenuSelected != null) {
                      onMenuSelected?.call(index);
                    }
                  },
                  child: const Icon(
                    Symbols.more_vert,
                    color: textColor,
                    size: 24,
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
