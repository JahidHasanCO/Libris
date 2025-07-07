import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:libris/modules/private_folder_pin/private_folder_pin.dart';
import 'package:libris/router/router.dart' show AsPathExt, Routes;

class PrivateFolderPinPage extends StatelessWidget {
  const PrivateFolderPinPage({super.key});

  static final route = GoRoute(
    path: Routes.privateFolderPin.asPath,
    name: Routes.privateFolderPin,
    builder: (context, state) {
      return const PrivateFolderPinPage();
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
    return const PrivateFolderPinView();
  }
}
