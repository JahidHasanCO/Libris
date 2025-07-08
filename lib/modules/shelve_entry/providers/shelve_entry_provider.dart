import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/modules/shelve_entry/shelve_entry.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/shelf.dart';
import 'package:libris/shared/repo/repo.dart';

class ShelveEntryProvider extends AutoDisposeNotifier<ShelveEntryState> {
  late ShelveRepo _repo;

  @override
  ShelveEntryState build() {
    _repo = ref.read(shelveRepoProvider);
    return const ShelveEntryState();
  }

  Future<void> add(String title) async {
    state = state.copyWith(status: State.loading, message: '');
    final now = DateTime.now();
    final shelf = Shelf(
      name: title,
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
    await _repo.insertShelf(shelf);
    state = state.copyWith(
      status: State.success,
      message: 'Shelf added successfully',
    );
  }

  Future<void> update(String title, Shelf previous) async {
    state = state.copyWith(status: State.loading, message: '');
    final now = DateTime.now();
    final shelf = previous.copyWith(
      name: title,
      updatedAt: now.toIso8601String(),
    );
    await _repo.updateShelf(shelf);
    state = state.copyWith(
      status: State.success,
      message: 'Shelf update successfully',
    );
  }
}
