import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/modules/private_folder/widgets/pdf_list.dart';
import 'package:libris/router/router.dart';
import 'package:libris/shared/models/models.dart';
import 'package:libris/shared/widgets/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

class PrivateFolderView extends ConsumerStatefulWidget {
  const PrivateFolderView({super.key});

  @override
  PdfReadViewState createState() => PdfReadViewState();
}

class PdfReadViewState extends ConsumerState<PrivateFolderView> {
  Category? category;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(privateFolderProvider.notifier).onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.select(
      privateFolderProvider,
      (s) => s.status.isLoading,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Private Folder',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: isLoading
            ? _emptyOrLoadingBody(ref, isLoading: true)
            : ProviderSelector(
                provider: privateFolderProvider,
                selector: (s) => s.privatePdfs,
                builder: (context, pdfs) {
                  if (pdfs.isEmpty) return _emptyOrLoadingBody(ref);
                  return _body(ref);
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final data = await ref.read(pdfEntryProvider.notifier).import();
              if (data != null && context.mounted) {
                await context.pushNamed(
                  Routes.pdfRead,
                  pathParameters: {'id': data.id.toString()},
                );
                if (!context.mounted) return;
                await ref.read(homeProvider.notifier).onRefresh();
              }
            });
          },
          elevation: 0,
          backgroundColor: primaryColor,
          child: const Icon(
            Symbols.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _emptyOrLoadingBody(WidgetRef ref, {bool isLoading = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Image.asset(
                    'assets/images/private_folder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Blur filter
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Image.asset(
                        'assets/images/private_folder.png',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 200,
                        errorBuilder: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'No Private PDFs',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _body(WidgetRef ref) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Image.asset(
              'assets/images/private_folder.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: ColoredBox(
            color: backgroundColor.withAlpha(200),
            child: RefreshIndicator(
              onRefresh: () async =>
                  ref.read(privateFolderProvider.notifier).onRefresh(),
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [PdfList()],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
