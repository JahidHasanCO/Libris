import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/repo.dart';
import 'package:pdf_reader/modules/category_details/category_details.dart';
import 'package:pdf_reader/shared/enums/enums.dart';
import 'package:pdf_reader/shared/repo/pdf_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetailsProvider
    extends AutoDisposeNotifier<CategoryDetailsState> {
  late PdfRepo _pdfRepo;
  SharedPreferences? _prefs;
  int? _categoryId;

  @override
  CategoryDetailsState build() {
    _pdfRepo = ref.read(pdfRepoProvider);
    return const CategoryDetailsState(status: State.loading);
  }

  Future<void> onInit(int categoryId) async {
    _categoryId = categoryId;
    _prefs = await SharedPreferences.getInstance();
    final pdfViewType = _prefs?.getInt('pdf_view_type') ?? 0;
    state = state.copyWith(
      pdfViewType: pdfViewType,
    );
    await getPdfs();
  }

  Future<void> onRefresh() async {
    state = state.copyWith(status: State.loading);
    await getPdfs();
    state = state.copyWith(status: State.success);
  }

  Future<void> getPdfs() async {
    try {
      final data = await _pdfRepo.getAllPdfs(categoryId: _categoryId);
      state = state.copyWith(
        status: State.success,
        categoryPdfs: data,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        status: State.error,
        message: e.toString(),
      );
    }
  }

  Future<void> changePdfViewType(int viewType) async {
    if (viewType == state.pdfViewType) return;
    await _prefs?.setInt('pdf_view_type', viewType);
    state = state.copyWith(pdfViewType: viewType);
  }
}
