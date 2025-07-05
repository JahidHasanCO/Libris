import 'package:pdf_reader/core/services/db/database.dart';
import 'package:pdf_reader/core/utils/extension/object.dart';
import 'package:pdf_reader/shared/models/models.dart';

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
}
