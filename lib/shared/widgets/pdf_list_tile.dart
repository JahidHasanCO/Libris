import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class PdfListTile extends StatelessWidget {
  const PdfListTile({
    required this.title,
    required this.category,
    super.key,
    this.onTap,
  });
  final String title;
  final String category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.picture_as_pdf,
            color: greyColor,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: greyLightColor.withValues(alpha: 0.3),
        title: Text(title),
        subtitle: Text(category),
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
        trailing: Icon(
          Icons.chevron_right,
          color: textColorLight.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
