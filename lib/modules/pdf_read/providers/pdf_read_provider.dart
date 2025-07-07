import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/core/utils/extension/object.dart';
import 'package:libris/modules/pdf_read/pdf_read.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/pdf.dart';
import 'package:libris/shared/repo/pdf_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfReadProvider extends AutoDisposeNotifier<PdfReadState> {
  late PdfRepo _repo;
  SharedPreferences? prefs;
  Timer? _timer;
  PDFViewController? pdfViewController;
  DateTime? _startTime;
  Timer? _autoScrollTimer;

  @override
  PdfReadState build() {
    _repo = ref.read(pdfRepoProvider);
    ref.onDispose(_dispose);
    return PdfReadState(
      status: State.loading,
      pdf: PDF(filePath: ''),
    );
  }

  Future<void> onInit(int id) async {
    prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs?.getBool('pdf_theme') ?? false;
    final speed = prefs?.getInt('auto_read_speed') ?? 60;
    final pdf = await _getPdf(id);
    state = state.copyWith(
      isDarkMode: isDarkMode,
      autoScrollSpeed: speed,
      status: State.success,
      pdf: pdf,
      currentPage: pdf?.currentPage,
    );
  }

  Future<PDF?> _getPdf(int id) async {
    final pdf = await _repo.getPdfById(id);
    return pdf;
  }

  void onPageError() => state = state.copyWith(
    status: State.error,
    isPdfReady: false,
    statusMsg: 'Page loading error',
  );

  void onRender(int? pages) => state = state.copyWith(
    status: State.success,
    isPdfReady: true,
    totalPages: pages ?? 0,
  );

  void onPageChanged(int? page, int? total) {
    'onPageChanged: $page, $total'.doPrint();
    state = state.copyWith(
      currentPage: page ?? 0 + 1,
      totalPages: total ?? 0,
    );
    onShowSlider(isShow: !state.isAutoScrolling);
  }

  void onShowSlider({bool isShow = true}) {
    _timer?.cancel(); // Cancel previous timer if any
    state = state.copyWith(isShowSlider: isShow);

    if (isShow) {
      _timer = Timer(const Duration(seconds: 3), () {
        state = state.copyWith(isShowSlider: false);
        _timer = null;
      });
    } else {
      _timer = null;
    }
  }

  Future<void> onSliderChange(double value) async {
    state = state.copyWith(currentPage: value.toInt());
    await _goToPage(state.currentPage);
  }

  Future<void> onViewCreated(PDFViewController controller) async {
    'PDFViewController viewCreated'.doPrint();
    _startTime ??= DateTime.now(); // Initialize start time only once
    pdfViewController = controller;
    if (state.currentPage != 0 && state.currentPage <= state.totalPages) {
      await _goToPage(state.currentPage);
    }
  }

  void toggleAppBarVisibility() {
    state = state.copyWith(isAppBarVisible: !state.isAppBarVisible);
    if (state.isAppBarVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  void toggleOrientation() {
    if (state.isLandscape) {
      // Lock to portrait mode
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );
    } else {
      // Lock to landscape mode
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
      );
    }
    state = state.copyWith(isLandscape: !state.isLandscape);
  }

  void goFirstPage() {
    if (state.currentPage != 0) {
      _goToPage(0);
      state = state.copyWith(autoScrollStartTime: DateTime.now());
    }
  }

  void nextPage() {
    final next = state.currentPage + 1;
    // Check if next page is within bounds
    if (next >= state.totalPages) {
      stopAutoScroll();
      return;
    }
    _goToPage(next);
    state = state.copyWith(autoScrollStartTime: DateTime.now());
  }

  void prevPage() {
    final prev = state.currentPage - 1;
    _goToPage(prev);
    state = state.copyWith(autoScrollStartTime: DateTime.now());
  }

  void startAutoScroll() {
    _autoScrollTimer?.cancel();
    state = state.copyWith(
      isAutoScrolling: true,
      autoScrollStartTime: DateTime.now(),
    );

    _autoScrollTimer = Timer.periodic(
      Duration(seconds: state.autoScrollSpeed),
      (_) async {
        if (state.currentPage < state.totalPages - 1) {
          await _goToPage(state.currentPage + 1);
          state = state.copyWith(autoScrollStartTime: DateTime.now());
        } else {
          stopAutoScroll();
        }
      },
    );
  }

  void stopAutoScroll() {
    _autoScrollTimer?.cancel();
    state = state.copyWith(
      isAutoScrolling: false,
      autoScrollStartTime: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  void toggleAutoScroll() {
    state.isAutoScrolling ? stopAutoScroll() : startAutoScroll();
  }

  Future<void> setSpeed(int seconds) async {
    await prefs?.setInt('auto_read_speed', seconds);
    final wasAutoScrolling = state.isAutoScrolling;
    stopAutoScroll();
    state = state.copyWith(autoScrollSpeed: seconds);
    if (wasAutoScrolling) {
      startAutoScroll();
    }
  }

  // private methods
  Future<void> _goToPage(int page) async {
    'goToPage: $page'.doPrint();
    if (page >= 0 &&
        page < state.totalPages &&
        pdfViewController != null &&
        state.isPdfReady) {
      try {
        await pdfViewController!.setPage(page);
        'Page set to: $page'.doPrint();
      } on Exception catch (e) {
        e.doPrint(level: 3);
      }
    }
  }

  Future<void> _updateLastRead() async {
    await _repo.updateEbookRead(
      id: state.pdf.id ?? 0,
      lastReadPage: state.currentPage + 1,
      totalPages: state.totalPages,
    );
    await ref.read(homeProvider.notifier).onRefresh();
  }

  Future<void> _dispose() async {
    if (state.isLandscape) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _timer?.cancel();
    _autoScrollTimer?.cancel();
    await _updateLastRead();
  }
}
