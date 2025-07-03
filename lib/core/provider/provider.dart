import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/modules/onboard/onboard.dart';

final onboardProvider =
    AutoDisposeNotifierProvider<OnboardProvider, OnboardState>(
      OnboardProvider.new,
    );
