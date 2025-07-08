import 'package:libris/shared/models/models.dart';

class CategoryPDF {
  CategoryPDF({
    required this.id,
    required this.filePath,
    this.name,
    this.size,
    this.coverPath,
    this.totalPages,
    this.currentPage = 0,
    this.categoryId,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryPDF.fromMap(Map<String, dynamic> json) => CategoryPDF(
    id: json['id'] as int,
    filePath: json['file_path'] as String,
    name: json['name'] as String?,
    size: json['size'] as int?,
    coverPath: json['cover_path'] as String?,
    totalPages: json['total_pages'] as int?,
    currentPage: json['current_page'] as int? ?? 0,
    categoryId: json['category_id'] as int?,
    categoryName: json['category_name'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  final int id;
  final String filePath;
  final String? name;
  final int? size;
  final String? coverPath;
  final int? totalPages;
  final int currentPage;
  final int? categoryId;
  final String? categoryName;
  final String? createdAt;
  final String? updatedAt;

  PDF toPDF() {
    return PDF(
      id: id,
      filePath: filePath,
      name: name,
      size: size,
      coverPath: coverPath,
      totalPages: totalPages,
      currentPage: currentPage,
      categoryId: categoryId ?? 0,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
