import 'package:equatable/equatable.dart';
import 'package:libris/shared/models/category.dart';


class AppState extends Equatable{

  const AppState({
    this.categories = const [],
  });
  final List<Category> categories;

  AppState copyWith({
    List<Category>? categories,
  }) {
    return AppState(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [categories];
}
