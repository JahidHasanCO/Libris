import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/modules/bottom_navigation/bottom_navigation.dart'
    show BottomNavigationProvider;
import 'package:pdf_reader/modules/onboard/onboard.dart';

final bottomNavigationProvider =
    NotifierProvider<BottomNavigationProvider, int>(
      BottomNavigationProvider.new,
    );

final onboardProvider =
    AutoDisposeNotifierProvider<OnboardProvider, OnboardState>(
      OnboardProvider.new,
    );
