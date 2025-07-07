import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/repo.dart';
import 'package:pdf_reader/modules/private_folder/private_folder.dart';
import 'package:pdf_reader/shared/enums/enums.dart';
import 'package:pdf_reader/shared/repo/pdf_repo.dart';
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

  Future<void> changePdfViewType(int viewType) async {
    if (viewType == state.pdfViewType) return;
    await _prefs?.setInt('pdf_view_type', viewType);
    state = state.copyWith(pdfViewType: viewType);
  }
}
