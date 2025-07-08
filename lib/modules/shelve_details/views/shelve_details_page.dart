import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:libris/modules/shelve_details/shelve_details.dart';
import 'package:libris/router/router.dart' show AsPathExt, Routes;

class ShelveDetailsPage extends StatelessWidget {
  const ShelveDetailsPage({required this.id, super.key});

  final int id;

  static final route = GoRoute(
    path: '${Routes.shelveDetails.asPath}/:id',
    name: Routes.shelveDetails,
    builder: (context, state) {
      final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
      return ShelveDetailsPage(id: id);
    },
  );

  @override
  Widget build(BuildContext context) {
    return ShelveDetailsView(id: id);
  }
}
