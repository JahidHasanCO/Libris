import 'package:equatable/equatable.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/models/category_pdf.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = State.initial,
    this.message = '',
    this.categoryPdfs = const [],
    this.categoryViewType = 0,
  });
  final State status;
  final String message;
  final List<CategoryPDF> categoryPdfs;
  final int categoryViewType;

  HomeState copyWith({
    State? status,
    String? message,
    List<CategoryPDF>? categoryPdfs,
    int? categoryViewType,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      categoryPdfs: categoryPdfs ?? this.categoryPdfs,
      categoryViewType: categoryViewType ?? this.categoryViewType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    categoryPdfs,
    categoryViewType,
  ];
}
