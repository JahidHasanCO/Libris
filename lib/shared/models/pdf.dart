class PDF {
  PDF({
    required this.filePath,
    this.id,
    this.name,
    this.size,
    this.coverPath,
    this.totalPages,
    this.currentPage = 0,
    this.categoryId = 31,
    this.isProtected = false,
    this.createdAt,
    this.updatedAt,
  });

  factory PDF.fromMap(Map<String, dynamic> json) => PDF(
    id: json['id'] as int?,
    filePath: json['file_path'] as String,
    name: json['name'] as String?,
    size: json['size'] as int?,
    coverPath: json['cover_path'] as String?,
    totalPages: json['total_pages'] as int?,
    currentPage: json['current_page'] as int? ?? 0,
    categoryId: json['category_id'] as int? ?? 31,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    isProtected: json['is_protected'] == 1,
  );

  final int? id;
  final String filePath;
  final String? name;
  final int? size;
  final bool? isProtected;
  final String? coverPath;
  final int? totalPages;
  final int categoryId;
  final int currentPage;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toMap() => {
    'id': id,
    'file_path': filePath,
    'name': name,
    'size': size,
    'cover_path': coverPath,
    'total_pages': totalPages,
    'current_page': currentPage,
    'category_id': categoryId,
    'is_protected': (isProtected ?? false) == true ? 1 : 0,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  PDF copyWith({
    int? id,
    String? filePath,
    String? name,
    int? size,
    String? coverPath,
    int? totalPages,
    int? currentPage,
    int? categoryId,
    bool? isProtected,
    String? createdAt,
    String? updatedAt,
  }) {
    return PDF(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      name: name ?? this.name,
      size: size ?? this.size,
      coverPath: coverPath ?? this.coverPath,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      categoryId: categoryId ?? this.categoryId,
      isProtected: isProtected ?? this.isProtected,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
