import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/provider/repo.dart';
import 'package:pdf_reader/modules/pdf_add/pdf_add.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/models/category.dart';
import 'package:pdf_reader/shared/repo/category_repo.dart';
import 'package:pdf_reader/shared/repo/pdf_repo.dart';

class PdfAddProvider extends AutoDisposeNotifier<PdfAddState> {
  late PdfRepo _repo;
  late CategoryRepo _categoryRepo;

  @override
  PdfAddState build() {
    _repo = ref.read(pdfRepoProvider);
    _categoryRepo = ref.read(categoryRepoProvider);
    return const PdfAddState();
  }

  Future<void> import({bool isPrivate = false}) async {
    state = state.copyWith(status: State.loading, isBottomSheetOpen: false);
    final data = await _repo.importFromFile(isPrivate: isPrivate);
    if (data == null || data.id == null) {
      state = state.copyWith(
        status: State.error,
        message: 'No PDF files found',
      );
    } else {
      final category = await _categoryRepo.getCategoryById(
        data.categoryId,
      );
      state = state.copyWith(
        status: State.success,
        pdf: data,
        title: data.name,
        selectedCategory: category,
        isBottomSheetOpen: true,
        message: 'PDF files imported successfully',
      );
    }
  }

  void onCategoryChanged(Category? category) {
    state = state.copyWith(selectedCategory: category);
  }

  Future<void> updatePdf(String title) async {
    if (state.pdf == null) return;
    final updatedPdf = state.pdf!.copyWith(
      name: title,
      categoryId: state.selectedCategory?.id,
    );
    await _repo.update(updatedPdf);
    state = state.copyWith(
      pdf: updatedPdf,
      title: title,
      isBottomSheetOpen: false,
    );
  }
}
