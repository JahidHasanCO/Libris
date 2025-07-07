import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/modules/private_folder_pin/private_folder_pin.dart';
import 'package:pdf_reader/shared/widgets/provider_selector.dart';

class PrivateFolderPinView extends ConsumerStatefulWidget {
  const PrivateFolderPinView({super.key});

  @override
  BottomNavigationViewState createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends ConsumerState<PrivateFolderPinView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(privateFolderPinProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Private Folder'),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return ProviderSelector(
      provider: privateFolderPinProvider,
      selector: (s) => s.isPinSet,
      builder: (context, isPinSet) {
        return isPinSet ? const PinVerification() : const PinSet();
      },
    );
  }
}
