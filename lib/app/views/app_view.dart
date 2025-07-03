import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/theme/app_theme.dart';
import 'package:pdf_reader/router/router.dart';

class MyAppView extends ConsumerStatefulWidget {
  const MyAppView({super.key});

  @override
  ConsumerState<MyAppView> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyAppView> {
  @override
  Widget build(BuildContext context) {
    final initialLocation = Routes.onboard.asPath;
    final router = AppRouter(initialLocation: initialLocation);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SoftMax',
      routerConfig: router.config,
      theme: AppTheme.appThemeLight,
    );
  }
}
