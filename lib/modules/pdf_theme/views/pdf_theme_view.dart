import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';

class PdfThemeView extends ConsumerStatefulWidget {
  const PdfThemeView({super.key});

  @override
  PdfThemeViewState createState() => PdfThemeViewState();
}

class PdfThemeViewState extends ConsumerState<PdfThemeView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pdfThemeProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text('PDF Theme'),
        ),
        body: state.when(
          data: _body,
          error: (_, _) => _error(),
          loading: _loading,
        ),
      ),
    );
  }

  Widget _error() {
    return const Center(
      child: Text('Error loading PDF themes'),
    );
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _body(bool value) {
    return SwitchListTile(
      title: const Text('Dark Mode', style: TextStyle(fontSize: 16)),
      value: value,
      subtitle: const Text(
        'Enable dark mode for PDF reader',
        style: TextStyle(
          fontSize: 14,
          color: textGrayColor,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      onChanged: ref.read(pdfThemeProvider.notifier).toggleTheme,
    );
  }
}
