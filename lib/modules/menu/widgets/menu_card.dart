import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(icon, size: 24),
        title: Text(title),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        titleTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        subtitle: Text(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitleTextStyle: const TextStyle(
          fontSize: 12,
          color: greyColor,
        ),
        trailing: trailing,
        tileColor: greyLightColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: onTap,
      ),
    );
  }
}
