import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/core/utils/extension/ref.dart';
import 'package:pdf_reader/modules/pdf_read/pdf_read.dart';
import 'package:pdf_reader/shared/widgets/provider_selector.dart';

class PdfReadView extends ConsumerStatefulWidget {
  const PdfReadView({required this.pdfId, super.key});

  final int pdfId;

  @override
  PdfReadViewState createState() => PdfReadViewState();
}

class PdfReadViewState extends ConsumerState<PdfReadView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(pdfReadProvider.notifier).onInit(widget.pdfId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(pdfReadProvider.notifier);

    final isAutoScrolling = ref.select(
      pdfReadProvider,
      (s) => s.isAutoScrolling,
    );
    final isAppBarVisible = ref.select(
      pdfReadProvider,
      (s) => s.isAppBarVisible,
    );
    final isLandscape = ref.select(pdfReadProvider, (s) => s.isLandscape);
    final isDarkMode = ref.select(pdfReadProvider, (s) => s.isDarkMode);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDarkMode ? Colors.black : backgroundColor,
      appBar: isAppBarVisible && !isAutoScrolling
          ? AppBar(
              elevation: 0,
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              title: ProviderSelector(
                provider: pdfReadProvider,
                selector: (state) => state.pdf,
                builder: (context, pdf) {
                  return Text(
                    pdf.name ?? '',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              actions: [
                if (isLandscape)
                  const SizedBox.shrink()
                else
                  IconButton(
                    icon: Icon(
                      isAutoScrolling
                          ? Icons.stop_circle_outlined
                          : Icons.play_arrow,
                    ),
                    iconSize: 22,
                    tooltip: 'Auto Scroll',
                    onPressed: () {
                      if (isAutoScrolling) {
                        notifier.stopAutoScroll();
                      } else {
                        notifier.startAutoScroll();
                      }
                    },
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                IconButton(
                  icon: const Icon(Icons.screen_rotation_alt_outlined),
                  iconSize: 22,
                  tooltip: 'Orientation Change',
                  onPressed: () {
                    if (isAutoScrolling) {
                      notifier.stopAutoScroll();
                    }
                    notifier.toggleOrientation();
                  },
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ],
            )
          : isAppBarVisible && isAutoScrolling
          ? AppBar(
              elevation: 0,
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              title: Text(
                'Auto Reading Mode',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            )
          : null,
      body: Consumer(
        builder: (context, ref, child) {
          final status = ref.select(pdfReadProvider, (s) => s.status);
          final statusMsg = ref.select(pdfReadProvider, (s) => s.statusMsg);
          return status.isLoading
              ? const Center(child: CircularProgressIndicator())
              : status.isError
              ? Center(
                  child: Text(
                    statusMsg,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : _buildPdfView();
        },
      ),
    );
  }

  Widget _buildPdfView() {
    final notifier = ref.watch(pdfReadProvider.notifier);
    final state = ref.watch(pdfReadProvider);
    return GestureDetector(
      onDoubleTap: notifier.toggleAppBarVisibility,
      child: Column(
        children: [
          if (state.pdf.filePath.isEmpty)
            const Center(child: Text('Pdf not found'))
          else
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: state.isLandscape
                        ? MediaQuery.of(context).size.width
                        : null,
                    child: PDFView(
                      filePath: state.pdf.filePath,
                      fitEachPage: false,
                      autoSpacing: false,
                      backgroundColor: state.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      gestureRecognizers:
                          const <Factory<OneSequenceGestureRecognizer>>{
                            Factory<VerticalDragGestureRecognizer>(
                              VerticalDragGestureRecognizer.new,
                            ),
                            Factory<HorizontalDragGestureRecognizer>(
                              HorizontalDragGestureRecognizer.new,
                            ),
                          },
                      defaultPage:
                          state.pdf.currentPage > 0 && state.currentPage == 0
                          ? state.pdf.currentPage - 1
                          : state.currentPage,
                      nightMode: state.isDarkMode,
                      onPageError: (page, error) => notifier.onPageError(),
                      onError: (error) => notifier.onPageError(),
                      onRender: notifier.onRender,
                      onPageChanged: notifier.onPageChanged,
                      onViewCreated: notifier.onViewCreated,
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    right: 10,
                    bottom: 20,
                    child: VerticalSlider(),
                  ),
                ],
              ),
            ),
          // Scrollbar for fast navigation
          if (!state.isLandscape && state.totalPages > 0)
            Container(
              color: state.isDarkMode ? Colors.black : Colors.grey[100],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AutoScrollControls(),
                  if (state.isAppBarVisible && !state.isAutoScrolling) ...[
                    const SizedBox(height: 10),
                    Text(
                      'Page ${state.currentPage + 1} of ${state.totalPages}',
                      style: TextStyle(
                        color: state.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
