import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:libris/modules/about_us/about_us.dart';
import 'package:libris/router/router.dart' show AsPathExt, Routes;

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
    return const AboutUsView();
  }
}
