import 'package:equatable/equatable.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/models/models.dart';

class PdfAddState extends Equatable {
  const PdfAddState({
    this.status = State.initial,
    this.message = '',
    this.pdf,
  });
  final State status;
  final String message;
  final PDF? pdf;

  PdfAddState copyWith({
    State? status,
    String? message,
    PDF? pdf,
  }) {
    return PdfAddState(
      status: status ?? this.status,
      message: message ?? this.message,
      pdf: pdf ?? this.pdf,
    );
  }

  @override
  List<Object?> get props => [status, message, pdf];
}
