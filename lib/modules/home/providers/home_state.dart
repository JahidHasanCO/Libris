import 'package:equatable/equatable.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/models/category_pdf.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = State.initial,
    this.message = '',
    this.categoryPdfs = const [],
  });
  final State status;
  final String message;
  final List<CategoryPDF> categoryPdfs;

  HomeState copyWith({
    State? status,
    String? message,
    List<CategoryPDF>? categoryPdfs,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      categoryPdfs: categoryPdfs ?? this.categoryPdfs,
    );
  }

  @override
  List<Object?> get props => [status, message, categoryPdfs];
}
