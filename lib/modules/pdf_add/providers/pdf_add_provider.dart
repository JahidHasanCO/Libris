import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/repo.dart';
import 'package:pdf_reader/modules/pdf_add/pdf_add.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/repo/pdf_repo.dart';

class PdfAddProvider extends AutoDisposeNotifier<PdfAddState> {
  late PdfRepo _repo;

  @override
  PdfAddState build() {
    _repo = ref.read(pdfRepoProvider);
    return const PdfAddState();
  }

  Future<void> import() async {
    state = state.copyWith(status: State.loading);
    final data = await _repo.importFromFile();
    if (data == null || data.id == null) {
      state = state.copyWith(
        status: State.error,
        message: 'No PDF files found',
      );
    } else {
      state = state.copyWith(
        status: State.success,
        pdf: data,
        message: 'PDF files imported successfully',
      );
    }
  }
}
