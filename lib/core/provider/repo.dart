import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/shared/repo/category_repo.dart';
import 'package:pdf_reader/shared/repo/pdf_repo.dart';

final categoryRepoProvider = Provider<CategoryRepo>((ref) => CategoryRepo());
final pdfRepoProvider = Provider<PdfRepo>((ref) => PdfRepo());
