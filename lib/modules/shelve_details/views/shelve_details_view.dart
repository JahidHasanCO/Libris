import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/modules/shelve_details/shelve_details.dart';
import 'package:libris/shared/widgets/widgets.dart';

class ShelveDetailsView extends ConsumerStatefulWidget {
  const ShelveDetailsView({required this.id, super.key});

  final int id;

  @override
  PdfReadViewState createState() => PdfReadViewState();
}

class PdfReadViewState extends ConsumerState<ShelveDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(shelveDetailsProvider.notifier).onInit(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.select(
      shelveDetailsProvider,
      (s) => s.status.isLoading,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: ProviderSelector(
            provider: shelveDetailsProvider,
            selector: (s) => s.shelf,
            builder: (context, shelf) {
              return Text(
                shelf.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            },
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
                provider: shelveDetailsProvider,
                selector: (s) => s.pdfList.isEmpty,
                builder: (context, isEmpty) {
                  if (isEmpty) return _emptyOrLoadingBody(ref);
                  return _body(ref);
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await PdfAddBottomSheet.show(context);
            await ref.read(shelveDetailsProvider.notifier).onRefresh();
          },
          backgroundColor: primaryColor,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
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
            'No PDFs found in this shelve.',
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
                  ref.read(shelveDetailsProvider.notifier).onRefresh(),
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
