import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class PdfListTile extends StatelessWidget {
  const PdfListTile({
    required this.title,
    required this.subtitle,
    this.totalPages = 0,
    this.currentPage = 0,
    super.key,
    this.onTap,
  });
  final String title;
  final String subtitle;
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
                  Icons.picture_as_pdf,
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
              trailing: Icon(
                Icons.chevron_right,
                color: textColorLight.withValues(alpha: 0.5),
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
