import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:libris/modules/category_details/category_details.dart';
import 'package:libris/router/router.dart' show AsPathExt, Routes;

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage({required this.id, super.key});

  final int id;

  static final route = GoRoute(
    path: '${Routes.categoryDetails.asPath}/:id',
    name: Routes.categoryDetails,
    builder: (context, state) {
      final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
      return CategoryDetailsPage(id: id);
    },
  );

  @override
  Widget build(BuildContext context) {
    return CategoryDetailsView(id: id);
  }
}
