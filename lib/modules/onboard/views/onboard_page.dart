import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:pdf_reader/modules/onboard/onboard.dart';
import 'package:pdf_reader/router/router.dart' show AsPathExt, Routes;

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  static final route = GoRoute(
    path: Routes.onboard.asPath,
    name: Routes.onboard,
    builder: (context, state) {
      return const OnboardPage();
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
    return const OnboardView();
  }
}
