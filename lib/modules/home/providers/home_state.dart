import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/category_pdf.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = State.initial,
    this.message = '',
    this.categoryPdfs = const [],
    this.lastReadPdfs = const [],
    this.categoryViewType = 0,
    this.pdfViewType = 0,
  });
  final State status;
  final String message;
  final List<CategoryPDF> categoryPdfs;
  final List<CategoryPDF> lastReadPdfs;
  final int categoryViewType;
  final int pdfViewType;

  HomeState copyWith({
    State? status,
    String? message,
    List<CategoryPDF>? categoryPdfs,
    List<CategoryPDF>? lastReadPdfs,
    int? categoryViewType,
    int? pdfViewType,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      categoryPdfs: categoryPdfs ?? this.categoryPdfs,
      lastReadPdfs: lastReadPdfs ?? this.lastReadPdfs,
      categoryViewType: categoryViewType ?? this.categoryViewType,
      pdfViewType: pdfViewType ?? this.pdfViewType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    categoryPdfs,
    lastReadPdfs,
    categoryViewType,
    pdfViewType,
  ];
}
