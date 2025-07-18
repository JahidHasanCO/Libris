import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/app/views/app_view.dart';
import 'package:libris/core/services/db/database.dart';
import 'package:libris/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.initialize();
  final prefs = await SharedPreferences.getInstance();
  final onboarded = prefs.getBool('onboarded') ?? false;
  final initialLocation = onboarded
      ? Routes.bottomNavigation.asPath
      : Routes.onboard.asPath;
  runApp(
    ProviderScope(
      child: MyAppView(
        initialLocation: initialLocation,
      ),
    ),
  );
}
