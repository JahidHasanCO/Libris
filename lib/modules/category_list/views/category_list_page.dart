import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute;
import 'package:libris/modules/category_list/category_list.dart';
import 'package:libris/router/router.dart' show AsPathExt, Routes;

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  static final route = GoRoute(
    path: Routes.categoryList.asPath,
    name: Routes.categoryList,
    builder: (context, state) {
      return const CategoryListPage();
    },
  );

  @override
  Widget build(BuildContext context) {
    return const CategoryListView();
  }
}
