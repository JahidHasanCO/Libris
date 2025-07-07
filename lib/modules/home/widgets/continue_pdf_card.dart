import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:libris/core/theme/colors.dart';

class ContinuePdfCard extends StatelessWidget {
  const ContinuePdfCard({
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 300,
            child: Container(
              decoration: BoxDecoration(
                color: greyLightColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Symbols.picture_as_pdf,
                    color: greyColor,
                    size: 45,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 16, color: textColorLight),
                  ),
                  const Spacer(),
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
          ),
        ),
      ),
    );
  }
}
