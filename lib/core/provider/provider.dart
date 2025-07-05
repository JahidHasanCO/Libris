import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/app/app.dart';
import 'package:pdf_reader/modules/bottom_navigation/bottom_navigation.dart'
    show BottomNavigationProvider;
import 'package:pdf_reader/modules/onboard/onboard.dart';
import 'package:pdf_reader/modules/pdf_add/pdf_add.dart';

final appProvider = NotifierProvider<AppProvider, AppState>(AppProvider.new);

final bottomNavigationProvider =
    NotifierProvider<BottomNavigationProvider, int>(
      BottomNavigationProvider.new,
    );

final onboardProvider =
    AutoDisposeNotifierProvider<OnboardProvider, OnboardState>(
      OnboardProvider.new,
    );

final pdfAddProvider = AutoDisposeNotifierProvider<PdfAddProvider, PdfAddState>(
  PdfAddProvider.new,
);
