import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/modules/category_details/category_details.dart';
import 'package:libris/shared/models/models.dart';
import 'package:libris/shared/widgets/widgets.dart';

class CategoryDetailsView extends ConsumerStatefulWidget {
  const CategoryDetailsView({required this.id, super.key});

  final int id;

  @override
  PdfReadViewState createState() => PdfReadViewState();
}

class PdfReadViewState extends ConsumerState<CategoryDetailsView> {
  Category? category;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final categories = ref.read(appProvider).categories;
      category = categories.firstWhere(
        (cat) => cat.id == widget.id,
        orElse: () => Category(id: widget.id, name: 'Other'),
      );
      await ref.read(categoryDetailsProvider.notifier).onInit(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.select(
      categoryDetailsProvider,
      (s) => s.status.isLoading,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            category?.name ?? 'Category Details',
            style: const TextStyle(
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
                provider: categoryDetailsProvider,
                selector: (s) => s.categoryPdfs,
                builder: (context, categoryPdfs) {
                  if (categoryPdfs.isEmpty) return _emptyOrLoadingBody(ref);
                  return _body(ref);
                },
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
            'No PDFs found in this category',
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
                  ref.read(categoryDetailsProvider.notifier).onRefresh(),
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
