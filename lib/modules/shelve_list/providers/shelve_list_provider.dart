import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/modules/shelve_list/shelve_list.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/repo/repo.dart';

class ShelveListProvider extends Notifier<ShelveListState> {
  late ShelveRepo _repo;

  @override
  ShelveListState build() {
    _repo = ref.read(shelveRepoProvider);
    return const ShelveListState(status: State.loading);
  }

  Future<void> onInit() async {
    await _loadShelveList();
  }

  Future<void> onRefresh() async {
    await _loadShelveList();
  }

  Future<void> _loadShelveList() async {
    state = state.copyWith(status: State.loading, message: '');
    final data = await _repo.getAllShelves();
    state = state.copyWith(status: State.success, shelveList: data);
  }
}
