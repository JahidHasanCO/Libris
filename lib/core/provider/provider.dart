import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/app/app.dart';
import 'package:libris/modules/bottom_navigation/bottom_navigation.dart'
    show BottomNavigationProvider;
import 'package:libris/modules/category_details/category_details.dart';
import 'package:libris/modules/home/home.dart';
import 'package:libris/modules/onboard/onboard.dart';
import 'package:libris/modules/pdf_add/pdf_add.dart';
import 'package:libris/modules/pdf_read/pdf_read.dart';
import 'package:libris/modules/pdf_theme/pdf_theme.dart';
import 'package:libris/modules/private_folder/private_folder.dart';
import 'package:libris/modules/private_folder_pin/private_folder_pin.dart';

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
final privateFolderProvider =
    AutoDisposeNotifierProvider<PrivateFolderProvider, PrivateFolderState>(
      PrivateFolderProvider.new,
    );

final pdfThemeProvider =
    AutoDisposeAsyncNotifierProvider<PdfThemeProvider, bool>(
      PdfThemeProvider.new,
    );

final privateFolderPinProvider =
    AutoDisposeNotifierProvider<
      PrivateFolderPinProvider,
      PrivateFolderPinState
    >(
      PrivateFolderPinProvider.new,
    );
