import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/modules/pdf_read/pdf_read.dart';


class VerticalSlider extends ConsumerWidget {
  const VerticalSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pdfReadProvider);
    final notifier = ref.read(pdfReadProvider.notifier);
    return state.isShowSlider && state.isPdfReady && state.totalPages > 1
        ? Container(
            width: 30,
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 1, // Rotate the slider to vertical
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 0,
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbShape: SliderThumbShape(
                    thumbRadius: 10, // Adjust thumb size
                    thumbColor: primaryColor.withValues(alpha: 0.2),
                    thumbHeight: 40,
                    thumbWidth: 28,
                  ),
                  thumbColor: greyColor,
                  showValueIndicator: ShowValueIndicator.never,
                  valueIndicatorColor: primaryColor,
                  valueIndicatorShape:
                      const RectangularSliderValueIndicatorShape(),
                  valueIndicatorTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Slider(
                  value: state.currentPage.toDouble(),
                  max: (state.totalPages - 1).toDouble(),
                  divisions: state.totalPages - 1,
                  label: '${state.currentPage + 1}',
                  onChanged: notifier.onSliderChange,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
