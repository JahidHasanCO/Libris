class Shelf {
  Shelf({
    required this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Shelf.fromMap(Map<String, dynamic> map) {
    return Shelf(
      id: map['id'] as int?,
      name: map['name'] as String,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }
  final int? id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
