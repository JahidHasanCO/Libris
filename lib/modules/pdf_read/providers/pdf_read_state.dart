import 'package:equatable/equatable.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/models/pdf.dart';

class PdfReadState extends Equatable {
  const PdfReadState({
    required this.pdf,
    this.status = State.initial,
    this.statusMsg = '',
    this.isLandscape = false,
    this.isAppBarVisible = true,
    this.currentPage = 0,
    this.totalPages = 0,
    this.isPdfReady = false,
    this.isShowSlider = false,
    this.ebookTheme = 0,
    this.isAutoScrolling = false,
    this.autoScrollSpeed = 60,
    this.autoScrollStartTime,
  });
  final State status;
  final String statusMsg;
  final bool isLandscape;
  final bool isAppBarVisible;
  final int currentPage;
  final int totalPages;
  final bool isPdfReady;
  final bool isShowSlider;
  final int ebookTheme;
  final PDF pdf;
  final bool isAutoScrolling;
  final int autoScrollSpeed;
  final DateTime? autoScrollStartTime;

  bool get isDarkMode => ebookTheme == 1;

  @override
  List<Object?> get props => [
    status,
    statusMsg,
    isLandscape,
    isAppBarVisible,
    currentPage,
    totalPages,
    isPdfReady,
    isShowSlider,
    ebookTheme,
    pdf,
    isAutoScrolling,
    autoScrollSpeed,
    autoScrollStartTime,
  ];

  PdfReadState copyWith({
    State? status,
    String? statusMsg,
    bool? isLandscape,
    bool? isAppBarVisible,
    bool? isShowTips,
    int? currentPage,
    int? totalPages,
    bool? isPdfReady,
    bool? isShowSlider,
    int? ebookTheme,
    PDF? pdf,
    bool? isAutoScrolling,
    int? autoScrollSpeed,
    DateTime? autoScrollStartTime,
  }) {
    return PdfReadState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      isLandscape: isLandscape ?? this.isLandscape,
      isAppBarVisible: isAppBarVisible ?? this.isAppBarVisible,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isPdfReady: isPdfReady ?? this.isPdfReady,
      isShowSlider: isShowSlider ?? this.isShowSlider,
      ebookTheme: ebookTheme ?? this.ebookTheme,
      pdf: pdf ?? this.pdf,
      isAutoScrolling: isAutoScrolling ?? this.isAutoScrolling,
      autoScrollSpeed: autoScrollSpeed ?? this.autoScrollSpeed,
      autoScrollStartTime: autoScrollStartTime ?? this.autoScrollStartTime,
    );
  }
}
