import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/modules/pdf_add/pdf_add.dart';
import 'package:libris/shared/models/models.dart';
import 'package:libris/shared/repo/pdf_repo.dart';

class PdfAddProvider extends AutoDisposeNotifier<PdfAddState> {
  late PdfRepo _repo;

  @override
  PdfAddState build() {
    _repo = ref.read(pdfRepoProvider);
    return const PdfAddState();
  }

  Future<PDF?> import({bool isPrivate = false}) async {
    final data = await _repo.importFromFile(isPrivate: isPrivate);
    return data;
  }

  void onCategoryChanged(Category? category) {
    state = state.copyWith(selectedCategory: category);
  }

  Future<void> updatePdf(String title, CategoryPDF? entry) async {
    if (entry == null) return;
    final now = DateTime.now();
    final updatedPdf = entry.toPDF().copyWith(
      name: title,
      categoryId: state.selectedCategory?.id,
      updatedAt: now.toIso8601String(),
    );
    await _repo.update(updatedPdf);
  }
}
