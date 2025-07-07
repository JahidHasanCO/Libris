import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/models.dart';

class CategoryDetailsState extends Equatable {
  const CategoryDetailsState({
    this.status = State.initial,
    this.message = '',
    this.categoryPdfs = const [],
    this.pdfViewType = 0,
  });
  final State status;
  final String message;
  final List<PDF> categoryPdfs;
  final int pdfViewType;

  CategoryDetailsState copyWith({
    State? status,
    String? message,
    List<PDF>? categoryPdfs,
    int? pdfViewType,
  }) {
    return CategoryDetailsState(
      status: status ?? this.status,
      message: message ?? this.message,
      categoryPdfs: categoryPdfs ?? this.categoryPdfs,
      pdfViewType: pdfViewType ?? this.pdfViewType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    categoryPdfs,
    pdfViewType,
  ];
}
