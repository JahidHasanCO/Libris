import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:pdf_reader/modules/bottom_navigation/bottom_navigation.dart';
import 'package:pdf_reader/router/router.dart' show AsPathExt, Routes;

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  static final route = GoRoute(
    path: Routes.bottomNavigation.asPath,
    name: Routes.bottomNavigation,
    builder: (context, state) {
      return const BottomNavigationPage();
    },
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return const BottomNavigationView();
  }
}
