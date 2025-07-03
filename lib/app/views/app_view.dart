import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppView extends ConsumerStatefulWidget {
  const MyAppView({super.key});

  @override
  ConsumerState<MyAppView> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyAppView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
