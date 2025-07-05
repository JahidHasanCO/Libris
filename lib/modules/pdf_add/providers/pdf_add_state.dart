import 'package:equatable/equatable.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/models/models.dart';

class PdfAddState extends Equatable {
  const PdfAddState({
    this.status = State.initial,
    this.message = '',
    this.pdf,
    this.title = '',
    this.selectedCategory,
    this.isBottomSheetOpen = false,
  });
  final State status;
  final String message;
  final PDF? pdf;
  final String title;
  final Category? selectedCategory;
  final bool isBottomSheetOpen;



  PdfAddState copyWith({
    State? status,
    String? message,
    PDF? pdf,
    String? title,
    Category? selectedCategory,
    bool? isBottomSheetOpen,
  }) {
    return PdfAddState(
      status: status ?? this.status,
      message: message ?? this.message,
      pdf: pdf ?? this.pdf,
      title: title ?? this.title,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isBottomSheetOpen: isBottomSheetOpen ?? this.isBottomSheetOpen,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    pdf,
    title,
    selectedCategory,
    isBottomSheetOpen,
  ];
}
