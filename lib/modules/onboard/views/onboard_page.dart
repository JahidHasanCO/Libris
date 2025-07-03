import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:myapp/modules/onboard/onboard.dart';
import 'package:myapp/router/router.dart' show AsPathExt, Routes;

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
    return const OnboardView();
  }
}
