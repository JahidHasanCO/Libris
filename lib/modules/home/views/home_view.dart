import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/core/utils/extension/ref.dart';
import 'package:pdf_reader/modules/home/home.dart';
import 'package:pdf_reader/shared/widgets/provider_selector.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.select(homeProvider, (s) => s.status.isLoading);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('PDF Reader'),
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
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {},
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
    );
  }

  Widget _emptyOrLoadingBody(WidgetRef ref, {bool isLoading = false}) {
    return RefreshIndicator(
      onRefresh: () async => ref.read(homeProvider.notifier).onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
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
        ),
      ),
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
                  children: [CategoryList(), PdfList()],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
