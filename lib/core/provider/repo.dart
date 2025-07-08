import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/shared/repo/repo.dart';

final categoryRepoProvider = Provider<CategoryRepo>((ref) => CategoryRepo());

final pdfRepoProvider = Provider<PdfRepo>((ref) => PdfRepo());

final shelveRepoProvider = Provider<ShelveRepo>((ref) => ShelveRepo());
