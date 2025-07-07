import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/app/app.dart';
import 'package:libris/core/provider/repo.dart';
import 'package:libris/shared/repo/category_repo.dart';

class AppProvider extends Notifier<AppState>{

  late CategoryRepo _categoryRepo;

  @override
  AppState build() {
    _categoryRepo = ref.read(categoryRepoProvider);
    return const AppState();
  }

  Future<void> onInit() async {
    await loadCategories();
  }

  Future<void> loadCategories() async {
    final data = await _categoryRepo.getAllCategories();
    state = state.copyWith(categories: data);
  }
}