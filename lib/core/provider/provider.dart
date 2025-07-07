import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/app/app.dart';
import 'package:pdf_reader/modules/bottom_navigation/bottom_navigation.dart'
    show BottomNavigationProvider;
import 'package:pdf_reader/modules/category_details/category_details.dart';
import 'package:pdf_reader/modules/home/home.dart';
import 'package:pdf_reader/modules/onboard/onboard.dart';
import 'package:pdf_reader/modules/pdf_add/pdf_add.dart';
import 'package:pdf_reader/modules/pdf_read/pdf_read.dart';

final appProvider = NotifierProvider<AppProvider, AppState>(AppProvider.new);

final bottomNavigationProvider =
    NotifierProvider<BottomNavigationProvider, int>(
      BottomNavigationProvider.new,
    );

final homeProvider = NotifierProvider<HomeProvider, HomeState>(
  HomeProvider.new,
);

final categoryDetailsProvider =
    AutoDisposeNotifierProvider<CategoryDetailsProvider, CategoryDetailsState>(
      CategoryDetailsProvider.new,
    );

final onboardProvider =
    AutoDisposeNotifierProvider<OnboardProvider, OnboardState>(
      OnboardProvider.new,
    );

final pdfAddProvider = AutoDisposeNotifierProvider<PdfAddProvider, PdfAddState>(
  PdfAddProvider.new,
);
final pdfReadProvider =
    AutoDisposeNotifierProvider<PdfReadProvider, PdfReadState>(
      PdfReadProvider.new,
    );
