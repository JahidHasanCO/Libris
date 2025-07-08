import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/modules/private_folder/private_folder.dart';
import 'package:libris/shared/enums/enums.dart';
import 'package:libris/shared/repo/pdf_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivateFolderProvider extends AutoDisposeNotifier<PrivateFolderState> {
  late PdfRepo _pdfRepo;
  SharedPreferences? _prefs;

  @override
  PrivateFolderState build() {
    _pdfRepo = ref.read(pdfRepoProvider);
    return const PrivateFolderState(status: State.loading);
  }

  Future<void> onInit() async {
    _prefs = await SharedPreferences.getInstance();
    final pdfViewType = _prefs?.getInt('pdf_view_type') ?? 0;
    state = state.copyWith(pdfViewType: pdfViewType);
    await getPrivatePdfs();
  }

  Future<void> onRefresh() async {
    state = state.copyWith(status: State.loading);
    await getPrivatePdfs();
    state = state.copyWith(status: State.success);
  }

  Future<void> getPrivatePdfs() async {
    try {
      final data = await _pdfRepo.getAllPdfs(isProtected: true);
      state = state.copyWith(
        status: State.success,
        privatePdfs: data,
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

  Future<void> moveToPublic(int pdfId) async {
    await _pdfRepo.updateIsProtected(id: pdfId, isProtected: false);
    await onRefresh();
    await ref.read(homeProvider.notifier).onRefresh();
  }


  Future<void> changePdfViewType(int viewType) async {
    if (viewType == state.pdfViewType) return;
    await _prefs?.setInt('pdf_view_type', viewType);
    state = state.copyWith(pdfViewType: viewType);
  }
}
