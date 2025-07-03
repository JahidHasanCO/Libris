import 'package:equatable/equatable.dart';

class Onboard extends Equatable {
  const Onboard({
    required this.path,
    required this.title,
    required this.description,
  });
  final String path;
  final String title;
  final String description;

  Onboard copyWith({
    String? path,
    String? title,
    String? description,
  }) {
    return Onboard(
      path: path ?? this.path,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [path, title, description];
}
