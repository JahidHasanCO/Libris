import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/repo.dart';
import 'package:pdf_reader/modules/home/providers/home_state.dart';
import 'package:pdf_reader/shared/enums/enums.dart';
import 'package:pdf_reader/shared/repo/pdf_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends Notifier<HomeState> {
  late PdfRepo _pdfRepo;
  SharedPreferences? _prefs;

  @override
  HomeState build() {
    _pdfRepo = ref.read(pdfRepoProvider);
    return const HomeState(status: State.loading);
  }

  Future<void> onInit() async {
    _prefs = await SharedPreferences.getInstance();
    final categoryViewType = _prefs?.getInt('category_view_type') ?? 0;
    state = state.copyWith(
      categoryViewType: categoryViewType,
    );
    await getCategoryPdfs();
  }

  Future<void> onRefresh() async {
    state = state.copyWith(status: State.loading);
    await getCategoryPdfs();
    state = state.copyWith(status: State.success);
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

  Future<void> changeCategoryViewType(int viewType) async {
    if (viewType == state.categoryViewType) return;
    await _prefs?.setInt('category_view_type', viewType);
    state = state.copyWith(categoryViewType: viewType);
  }
}
