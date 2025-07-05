import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/app/app.dart';
import 'package:pdf_reader/core/provider/repo.dart';
import 'package:pdf_reader/shared/repo/category_repo.dart';

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