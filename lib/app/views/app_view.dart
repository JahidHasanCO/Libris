import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/app_theme.dart';
import 'package:libris/router/router.dart';

class MyAppView extends ConsumerStatefulWidget {
  const MyAppView({required this.initialLocation, super.key });

  final String initialLocation;

  @override
  ConsumerState<MyAppView> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyAppView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(appProvider.notifier).onInit();
    });
  }

  @override
  Widget build(BuildContext context) {

    final router = AppRouter(initialLocation: widget.initialLocation);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Libris',
      routerConfig: router.config,
      theme: AppTheme.appThemeLight,
    );
  }
}
