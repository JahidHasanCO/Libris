import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/models.dart';

class PdfAddState extends Equatable {
  const PdfAddState({
    this.status = State.initial,
    this.message = '',
    this.selectedCategory,
  });
  final State status;
  final String message;
  final Category? selectedCategory;

  PdfAddState copyWith({
    State? status,
    String? message,
    Category? selectedCategory,
  }) {
    return PdfAddState(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    selectedCategory,
  ];
}
