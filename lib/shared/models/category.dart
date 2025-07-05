class Category {
  Category({required this.name, this.id});

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json['id'] as int?,
    name: json['name'] as String,
  );
  final int? id;
  final String name;

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
  };
}
