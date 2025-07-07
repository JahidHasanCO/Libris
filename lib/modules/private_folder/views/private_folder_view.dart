import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/core/utils/extension/ref.dart';
import 'package:pdf_reader/modules/pdf_add/pdf_add.dart';
import 'package:pdf_reader/modules/private_folder/widgets/pdf_list.dart';
import 'package:pdf_reader/shared/models/models.dart';
import 'package:pdf_reader/shared/widgets/widgets.dart';

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

  void _listenForAddPdf() {
    ref
      ..listen(pdfAddProvider.select((s) => s.isBottomSheetOpen), (
        previous,
        next,
      ) {
        if (previous != next && next) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showModalBottomSheet<void>(
              context: context,
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
              if (mounted) ref.read(privateFolderProvider.notifier).onRefresh();
              if (mounted && Navigator.of(context).canPop()) {
                Navigator.pop(context);
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
  Widget build(BuildContext context) {
    _listenForAddPdf();
    final isLoading = ref.select(
      privateFolderProvider,
      (s) => s.status.isLoading,
    );
    return Scaffold(
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
            await ref.read(pdfAddProvider.notifier).import(isPrivate: true);
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
