import 'package:libris/core/services/db/database.dart';
import 'package:libris/core/utils/extension/object.dart';
import 'package:libris/shared/models/models.dart';

class ShelveRepo {
  final AppDatabase db = AppDatabase.instance;
  static const _tableName = 'shelves';
  static const _pdfTableName = 'pdf_shelf';

  Future<int> insertShelf(Shelf shelf) async {
    try {
      final database = await db.database;
      return await database.insert(_tableName, shelf.toMap());
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.insertShelf]');
      return 0;
    }
  }

  Future<Shelf?> getShelfById(int id) async {
    try {
      final database = await db.database;
      final result = await database.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return Shelf.fromMap(result.first);
      } else {
        return null;
      }
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.getShelfById]');
      return null;
    }
  }

  Future<List<Shelf>> getAllShelves() async {
    try {
      final database = await db.database;
      final result = await database.query(
        _tableName,
        orderBy: 'created_at DESC',
      );
      return result.map(Shelf.fromMap).toList();
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.getAllShelves]');
      return [];
    }
  }

  /// Update shelf
  Future<int> updateShelf(Shelf shelf) async {
    try {
      final database = await db.database;
      return await database.update(
        _tableName,
        shelf.toMap(),
        where: 'id = ?',
        whereArgs: [shelf.id],
      );
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.updateShelf]');
      return 0;
    }
  }

  /// Delete shelf
  Future<int> deleteShelf(int id) async {
    try {
      final database = await db.database;
      return await database.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.deleteShelf]');
      return 0;
    }
  }

  Future<int> insertPdfShelf(PdfShelf pdfShelf) async {
    try {
      final database = await db.database;
      return await database.insert(_pdfTableName, pdfShelf.toMap());
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.insertPdfShelf]');
      return 0;
    }
  }

  Future<int> insertMultiplePdfShelves(List<PdfShelf> pdfShelves) async {
    try {
      final database = await db.database;
      var insertedCount = 0;

      await database.transaction((txn) async {
        for (final pdfShelf in pdfShelves) {
          final id = await txn.insert(_pdfTableName, pdfShelf.toMap());
          if (id > 0) insertedCount++;
        }
      });

      return insertedCount;
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.insertMultiplePdfShelves]');
      return 0;
    }
  }

  Future<int> removePdfShelf(int id) async {
    try {
      final database = await db.database;
      return await database.delete(
        _pdfTableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.removePdfShelf]');
      return 0;
    }
  }

  Future<List<PDF>> getAllPdfsInShelf(int shelfId) async {
    try {
      final database = await db.database;
      final result = await database.rawQuery(
        '''
      SELECT p.*
      FROM pdfs p
      INNER JOIN pdf_shelf ps ON p.id = ps.pdf_id
      WHERE ps.shelf_id = ?
    ''',
        [shelfId],
      );

      return result.map(PDF.fromMap).toList();
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.getAllPdfsInShelf]');
      return [];
    }
  }

  Future<List<PDF>> getPdfsNotInShelf(int shelfId) async {
    try {
      final database = await db.database;
      final result = await database.rawQuery(
        '''
        SELECT * FROM pdfs 
        WHERE id NOT IN (
          SELECT pdf_id FROM pdf_shelf WHERE shelf_id = ?
        ) AND is_protected = 0
      ''',
        [shelfId],
      );

      return result.map(PDF.fromMap).toList();
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.getPdfsNotInShelf]');
      return [];
    }
  }

  Future<int> deletePdfShelf(int id) async {
    try {
      final database = await db.database;
      return await database.delete(
        _pdfTableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.deletePdfShelf]');
      return 0;
    }
  }

  /// Delete PDF-Shelf relation by pdfId and shelfId
  Future<int> deletePdfShelfByPdfAndShelf(int pdfId, int shelfId) async {
    try {
      final database = await db.database;
      return await database.delete(
        _pdfTableName,
        where: 'pdf_id = ? AND shelf_id = ?',
        whereArgs: [pdfId, shelfId],
      );
    } on Exception catch (e) {
      e.doPrint(prefix: '[ShelveRepo.deletePdfShelfByPdfAndShelf]');
      return 0;
    }
  }
}
