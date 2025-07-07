import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._init();
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('database.db');
    return _database!;
  }

  Future<void> initialize() async {
    await database;
  }

  Future<Database> _initDB(String fileName) async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDir.path, fileName);
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await _createCategoriesTable(db);
    await _createPdfsTable(db);
    await _createShelvesTable(db);
    await _createPdfShelfTable(db);
  }

  Future<void> _createPdfsTable(Database db) async {
    await db.execute('''
    CREATE TABLE pdfs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      file_path TEXT NOT NULL,
      name TEXT,
      size INTEGER,
      cover_path TEXT,
      total_pages INTEGER,
      current_page INTEGER DEFAULT 0,
      category_id INTEGER,
      created_at TEXT,
      updated_at TEXT,
      is_protected INTEGER DEFAULT 0,
      FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE SET NULL
    )
  ''');
  }

  Future<void> _createCategoriesTable(Database db) async {
    await db.execute('''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
  ''');

    final initialCategories = [
      'Fiction',
      'Non-Fiction',
      'Science Fiction',
      'Fantasy',
      'Horror',
      'Thriller',
      'Mystery',
      'Romance',
      'Historical Fiction',
      'Biography',
      'Self-Help',
      'Business',
      'Psychology',
      'Science',
      'Travel',
      'Health',
      'Cooking',
      'Poetry',
      'Young Adult',
      'Children’s',
      'Crime',
      'Adventure',
      'Humor',
      'Religion',
      'Politics',
      'Art',
      'Sports',
      'True Crime',
      'LGBTQ+',
      'Classics',
      'Others',
    ];

    for (final category in initialCategories) {
      await db.insert('categories', {'name': category});
    }
  }


  Future<void> _createShelvesTable(Database db) async {
    await db.execute('''
    CREATE TABLE shelves (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      created_at TEXT,
      updated_at TEXT
    )
  ''');
  }

  Future<void> _createPdfShelfTable(Database db) async {
    await db.execute('''
    CREATE TABLE pdf_shelf (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pdf_id INTEGER NOT NULL,
      shelf_id INTEGER NOT NULL,
      FOREIGN KEY(pdf_id) REFERENCES pdfs(id) ON DELETE CASCADE,
      FOREIGN KEY(shelf_id) REFERENCES shelves(id) ON DELETE CASCADE
    )
  ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
