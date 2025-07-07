import 'package:libris/core/services/db/database.dart';
import 'package:libris/core/utils/extension/object.dart';
import 'package:libris/shared/models/models.dart';

class CategoryRepo {
  final AppDatabase dbInstance = AppDatabase.instance;
  static const _tableName = 'categories';

  Future<List<Category>> getAllCategories() async {
    try {
      final db = await dbInstance.database;
      final result = await db.query(
        _tableName,
        orderBy: 'name COLLATE NOCASE ASC',
      );
      return result.map(Category.fromMap).toList();
    } on Exception catch (e) {
      e.toString().doPrint(prefix: '[getAllCategories]');
      return [];
    }
  }

  Future<Category?> getCategoryById(int id) async {
    try {
      final db = await dbInstance.database;
      final result = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isNotEmpty) {
        return Category.fromMap(result.first);
      }
      return null;
    } on Exception catch (e) {
      e.toString().doPrint(prefix: '[getCategoryById]');
      return null;
    }
  }
}
