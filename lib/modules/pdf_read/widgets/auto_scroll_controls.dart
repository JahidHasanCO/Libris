import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/modules/pdf_read/pdf_read.dart';
import 'package:libris/shared/widgets/provider_selector.dart';

class AutoScrollControls extends ConsumerWidget {
  const AutoScrollControls({super.key});

  static const List<Map<String, dynamic>> scrollSpeeds = [
    {'value': 15, 'label': 'Super Fast (15s)'},
    {'value': 30, 'label': 'Fast (30s)'},
    {'value': 60, 'label': 'Normal (1 min)'},
    {'value': 120, 'label': 'Slow (2 min)'},
    {'value': 240, 'label': 'Ultra Slow (4 min)'},
  ];

  String formatDurationLabel(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final minutes = seconds ~/ 60;
    return '${minutes}min${seconds % 60 > 0 ? ' ${seconds % 60}s' : ''}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAutoScrolling = ref.select(
      pdfReadProvider,
      (s) => s.isAutoScrolling,
    );
    final isDarkMode = ref.select(pdfReadProvider, (s) => s.isDarkMode);
    final autoScrollSpeed = ref.select(
      pdfReadProvider,
      (s) => s.autoScrollSpeed,
    );
    final notifier = ref.read(pdfReadProvider.notifier);

    if (!isAutoScrolling) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProviderSelector(
          provider: pdfReadProvider,
          selector: (state) => state.autoScrollStartTime,
          builder: (context, time) {
            return time != null
                ? AutoScrollProgressBar(
                    startTime: time,
                    durationSeconds: autoScrollSpeed,
                    isDarkMode: isDarkMode,
                  )
                : const SizedBox.shrink();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.first_page_rounded),
              iconSize: 24,
              visualDensity: VisualDensity.compact,
              color: isDarkMode ? Colors.white : Colors.black,
              tooltip: 'First',
              onPressed: notifier.goFirstPage,
            ),
            IconButton(
              icon: const Icon(Icons.skip_previous_rounded),
              iconSize: 24,
              visualDensity: VisualDensity.compact,
              color: isDarkMode ? Colors.white : Colors.black,
              tooltip: 'Previous',
              onPressed: notifier.prevPage,
            ),
            IconButton(
              icon: Icon(isAutoScrolling ? Icons.stop : Icons.play_arrow),
              iconSize: 30,
              visualDensity: VisualDensity.compact,
              color: isDarkMode ? Colors.white : Colors.black,
              tooltip: 'Pause/Play',
              onPressed: notifier.toggleAutoScroll,
            ),
            IconButton(
              icon: const Icon(Icons.skip_next_rounded),
              iconSize: 24,
              visualDensity: VisualDensity.compact,
              color: isDarkMode ? Colors.white : Colors.black,
              tooltip: 'Next',
              onPressed: notifier.nextPage,
            ),
            PopupMenuButton<int>(
              tooltip: 'Speed',
              iconSize: 20,
              icon: ProviderSelector(
                provider: pdfReadProvider,
                selector: (state) => state.autoScrollSpeed,
                builder: (context, speed) {
                  return Badge(
                    label: Text(formatDurationLabel(speed)),
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.speed,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
              onSelected: notifier.setSpeed,
              itemBuilder: (_) => scrollSpeeds
                  .map(
                    (e) => PopupMenuItem<int>(
                      value: e['value'] as int,
                      child: Text(e['label'] as String),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        Consumer(
          builder: (context, ref, child) {
            final currentPage = ref.select(
              pdfReadProvider,
              (value) => value.currentPage,
            );
            final totalPages = ref.select(
              pdfReadProvider,
              (value) => value.totalPages,
            );
            return Text(
              'Page ${currentPage + 1} of $totalPages',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
