import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/repo.dart';
import 'package:pdf_reader/modules/home/providers/home_state.dart';
import 'package:pdf_reader/shared/enums/enums.dart';
import 'package:pdf_reader/shared/repo/pdf_repo.dart';

class HomeProvider extends Notifier<HomeState> {
  late PdfRepo _pdfRepo;

  @override
  HomeState build() {
    _pdfRepo = ref.read(pdfRepoProvider);
    return const HomeState(status: State.loading);
  }

  Future<void> onInit() async {
    await getCategoryPdfs();
  }

  Future<void> getCategoryPdfs() async {
    try {
      final categoryPdfs = await _pdfRepo.getAllPdfsWithCategory();
      state = state.copyWith(
        status: State.success,
        categoryPdfs: categoryPdfs,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        status: State.error,
        message: e.toString(),
      );
    }
  }
}
