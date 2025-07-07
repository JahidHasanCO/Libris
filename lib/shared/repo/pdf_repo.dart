import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:pdf_reader/core/services/db/database.dart';
import 'package:pdf_reader/core/utils/extension/object.dart';
import 'package:pdf_reader/shared/models/category_pdf.dart';
import 'package:pdf_reader/shared/models/models.dart';

class PdfRepo {
  final AppDatabase db = AppDatabase.instance;
  static const _tableName = 'pdfs';

  Future<PDF?> importFromFile({bool isPrivate = false}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final database = await db.database;
      final existing = await database.query(
        _tableName,
        where: 'file_path = ?',
        whereArgs: [filePath],
        limit: 1,
      );
      if (existing.isNotEmpty) {
        return PDF.fromMap(existing.first);
      }

      final file = File(filePath);
      final size = await file.length();

      final name = basenameWithoutExtension(filePath);
      final now = DateTime.now().toIso8601String();

      final pdf = PDF(
        filePath: filePath,
        name: name,
        size: size,
        isProtected: isPrivate,
        createdAt: now,
        updatedAt: now,
      );

      final id = await database.insert(_tableName, pdf.toMap());
      return pdf.copyWith(id: id);
    }
    return null;
  }

  Future<PDF?> getPdfById(int id) async {
    final database = await db.database;
    final result = await database.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return PDF.fromMap(result.first);
    }
    return null;
  }

  Future<List<PDF>> getAllPdfs({
    int? categoryId,
    bool isProtected = false,
  }) async {
    final database = await db.database;

    var whereClause = '';
    final whereArgs = <Object?>[];

    whereClause += 'is_protected = ?';
    whereArgs.add(isProtected ? 1 : 0);

    if (categoryId != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'category_id = ?';
      whereArgs.add(categoryId);
    }

    final result = await database.query(
      'pdfs',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'created_at DESC',
    );

    return result.map(PDF.fromMap).toList();
  }

  Future<int> insert(PDF pdf) async {
    final database = await db.database;
    return database.insert(_tableName, pdf.toMap());
  }

  Future<int> update(PDF pdf) async {
    try {
      final database = await db.database;
      return database.update(
        _tableName,
        pdf.toMap(),
        where: 'id = ?',
        whereArgs: [pdf.id],
      );
    } on Exception catch (e) {
      e.doPrint(prefix: '[PdfRepo.update]');
      return 0;
    }
  }

  Future<int> delete(int id) async {
    final database = await db.database;
    return database.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateEbookRead({
    required int id,
    required int lastReadPage,
    required int totalPages,
  }) async {
    final database = await db.database;
    final now = DateTime.now().toIso8601String();
    return database.update(
      _tableName,
      {
        'current_page': lastReadPage,
        'total_pages': totalPages,
        'updated_at': now,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CategoryPDF>> getAllPdfsWithCategory() async {
    final database = await db.database;
    final result = await database.rawQuery('''
    SELECT pdfs.*, categories.name AS category_name
    FROM pdfs
    LEFT JOIN categories ON pdfs.category_id = categories.id
    WHERE pdfs.is_protected = 0
    ORDER BY pdfs.updated_at DESC
  ''');
    return result
        .map((json) => CategoryPDF.fromMap(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<CategoryPDF>> getLastReadCategoryPdfs({int limit = 5}) async {
    final database = await db.database;

    final result = await database.rawQuery(
      '''
    SELECT pdfs.*, categories.name AS category_name
    FROM pdfs
    LEFT JOIN categories ON pdfs.category_id = categories.id
    WHERE pdfs.current_page > 0
    AND pdfs.is_protected = 0
    ORDER BY pdfs.updated_at DESC
    LIMIT ?
  ''',
      [limit],
    );

    return result.isNotEmpty
        ? result
              .map((json) => CategoryPDF.fromMap(json as Map<String, dynamic>))
              .toList()
        : <CategoryPDF>[]; // return empty list if none found
  }
}
