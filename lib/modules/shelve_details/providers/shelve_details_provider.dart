import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/modules/shelve_details/shelve_details.dart';
import 'package:libris/shared/enums/enums.dart';
import 'package:libris/shared/models/models.dart';
import 'package:libris/shared/repo/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShelveDetailsProvider extends AutoDisposeNotifier<ShelveDetailsState> {
  late ShelveRepo _repo;
  late PdfRepo _pdfRepo;
  SharedPreferences? _prefs;
  int? _shelveId;

  @override
  ShelveDetailsState build() {
    _repo = ref.read(shelveRepoProvider);
    _pdfRepo = ref.read(pdfRepoProvider);
    return ShelveDetailsState(
      status: State.loading,
      shelf: Shelf(name: 'Other'),
    );
  }

  Future<void> onInit(int shelveId) async {
    _shelveId = shelveId;
    _prefs = await SharedPreferences.getInstance();
    final pdfViewType = _prefs?.getInt('pdf_view_type') ?? 0;
    state = state.copyWith(pdfViewType: pdfViewType);
    await getShelve();
    await getPdfs();
  }

  Future<void> onInsert() async {
    state = state.copyWith(insertAblePdfList: []);
    await _getInsertAblePdfList();
  }

  Future<void> onRefresh() async {
    state = state.copyWith(status: State.loading);
    await getShelve();
    await getPdfs();
    state = state.copyWith(status: State.success);
  }

  Future<void> getShelve() async {
    try {
      final data = await _repo.getShelfById(_shelveId ?? 0);
      state = state.copyWith(status: State.success, shelf: data);
    } on Exception catch (e) {
      state = state.copyWith(
        status: State.error,
        message: e.toString(),
      );
    }
  }

  Future<void> getPdfs() async {
    try {
      final data = await _repo.getAllPdfsInShelf(_shelveId ?? 0);
      state = state.copyWith(status: State.success, pdfList: data);
    } on Exception catch (e) {
      state = state.copyWith(
        status: State.error,
        message: e.toString(),
      );
    }
  }

  Future<void> _getInsertAblePdfList() async {
    try {
      final data = await _repo.getPdfsNotInShelf(_shelveId ?? 0);
      state = state.copyWith(status: State.success, insertAblePdfList: data);
    } on Exception catch (e) {
      state = state.copyWith(
        status: State.error,
        message: e.toString(),
      );
    }
  }

  Future<void> addPdfListToShelf(List<int> pdfIds) async {
    try {
      final pdfs = <PdfShelf>[];
      for (final id in pdfIds) {
        pdfs.add(PdfShelf(pdfId: id, shelfId: _shelveId ?? 0));
      }
      await _repo.insertMultiplePdfShelves(pdfs);
      await onRefresh();
    } on Exception catch (e) {
      state = state.copyWith(
        status: State.error,
        message: e.toString(),
      );
    }
  }

  Future<void> removePdfFromShelf(int pdfId) async {
    try {
      await _repo.removePdfShelf(pdfId);
      await onRefresh();
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

  Future<void> changePdfViewType(int viewType) async {
    if (viewType == state.pdfViewType) return;
    await _prefs?.setInt('pdf_view_type', viewType);
    state = state.copyWith(pdfViewType: viewType);
  }
}
