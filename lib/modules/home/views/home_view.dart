import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/modules/home/home.dart';
import 'package:libris/modules/pdf_add/pdf_add.dart';
import 'package:libris/router/router.dart';
import 'package:libris/shared/widgets/provider_selector.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  void _listenForAddPdf(WidgetRef ref) {
    ref
      ..listen(pdfAddProvider.select((s) => s.isBottomSheetOpen), (
        previous,
        next,
      ) {
        if (previous != next && next) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showModalBottomSheet<void>(
              context: ref.context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const PdfAddView(),
              ),
            ).then((value) {
              if (ref.context.mounted) {
                ref.read(homeProvider.notifier).onRefresh();
              }
              if (ref.context.mounted && Navigator.of(ref.context).canPop()) {
                Navigator.pop(ref.context);
              }
            });
          });
        }
      })
      ..listen(pdfAddProvider, (previous, next) {
        if (next.status.isError && ref.context.mounted) {
          Navigator.pop(ref.context);
          ScaffoldMessenger.of(ref.context).showSnackBar(
            SnackBar(content: Text(next.message)),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenForAddPdf(ref);
    final isLoading = ref.select(homeProvider, (s) => s.status.isLoading);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Symbols.import_contacts,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            Text('Libris'),
          ],
        ),
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Symbols.folder_managed),
            color: Colors.white,
            onPressed: () => context.pushNamed(Routes.privateFolderPin),
          ),
        ],
      ),
      body: isLoading
          ? _emptyOrLoadingBody(ref, isLoading: true)
          : ProviderSelector(
              provider: homeProvider,
              selector: (s) => s.categoryPdfs,
              builder: (context, categoryPdfs) {
                if (categoryPdfs.isEmpty) return _emptyOrLoadingBody(ref);
                return _body(ref);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await ref.read(pdfAddProvider.notifier).import();
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
                    'assets/images/empty_book.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Blur filter
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Image.asset(
                        'assets/images/empty_book.png',
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
            'No PDF files found',
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
              'assets/images/empty_book.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: ColoredBox(
            color: backgroundColor.withAlpha(200),
            child: RefreshIndicator(
              onRefresh: () async =>
                  ref.read(homeProvider.notifier).onRefresh(),
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [LastReadPdfList(), CategoryList(), PdfList()],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
