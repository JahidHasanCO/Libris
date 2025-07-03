import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/views/app_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyAppView()));
}
