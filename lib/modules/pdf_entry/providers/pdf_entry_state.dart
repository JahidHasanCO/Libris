import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/models.dart';

class PdfEntryState extends Equatable {
  const PdfEntryState({
    this.status = State.initial,
    this.message = '',
    this.selectedCategory,
  });
  final State status;
  final String message;
  final Category? selectedCategory;

  PdfEntryState copyWith({
    State? status,
    String? message,
    Category? selectedCategory,
  }) {
    return PdfEntryState(
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
