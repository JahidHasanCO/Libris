import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/core/utils/extension/object.dart';
import 'package:libris/modules/home/providers/home_state.dart';
import 'package:libris/shared/enums/enums.dart';
import 'package:libris/shared/repo/pdf_repo.dart';
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
    final pdfViewType = _prefs?.getInt('pdf_view_type') ?? 0;
    state = state.copyWith(
      categoryViewType: categoryViewType,
      pdfViewType: pdfViewType,
    );
    await getCategoryPdfs();
    await getLastReadCategoryPdfs();
  }

  Future<void> onRefresh() async {
    state = state.copyWith(status: State.loading);
    await getCategoryPdfs();
    await getLastReadCategoryPdfs();
    state = state.copyWith(status: State.success);
  }

  Future<void> getLastReadCategoryPdfs() async {
    try {
      final lastPdfs = await _pdfRepo.getLastReadCategoryPdfs();
      state = state.copyWith(lastReadPdfs: lastPdfs);
    } on Exception catch (e) {
      e.toString().doPrint();
    }
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

  Future<void> deletePdf(int pdfId) async {
    await _pdfRepo.delete(pdfId);
    await onRefresh();
  }

  Future<void> moveToPrivate(int pdfId) async {
    await _pdfRepo.updateIsProtected(id: pdfId, isProtected: true);
    await onRefresh();
  }

  Future<void> changeCategoryViewType(int viewType) async {
    if (viewType == state.categoryViewType) return;
    await _prefs?.setInt('category_view_type', viewType);
    state = state.copyWith(categoryViewType: viewType);
  }

  Future<void> changePdfViewType(int viewType) async {
    if (viewType == state.pdfViewType) return;
    await _prefs?.setInt('pdf_view_type', viewType);
    state = state.copyWith(pdfViewType: viewType);
  }
}
