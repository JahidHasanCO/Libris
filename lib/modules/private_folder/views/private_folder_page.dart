import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:libris/modules/private_folder/private_folder.dart';
import 'package:libris/router/router.dart' show AsPathExt, Routes;

class PrivateFolderPage extends StatelessWidget {
  const PrivateFolderPage({super.key});

  static final route = GoRoute(
    path: Routes.privateFolder.asPath,
    name: Routes.privateFolder,
    builder: (context, state) {
      return const PrivateFolderPage();
    },
  );

  @override
  Widget build(BuildContext context) {
    return const PrivateFolderView();
  }
}
