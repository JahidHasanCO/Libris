import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:pdf_reader/modules/about_us/about_us.dart';
import 'package:pdf_reader/router/router.dart' show AsPathExt, Routes;

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static final route = GoRoute(
    path: Routes.aboutUs.asPath,
    name: Routes.aboutUs,
    builder: (context, state) {
      return const AboutUsPage();
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
    return const AboutUsView();
  }
}
