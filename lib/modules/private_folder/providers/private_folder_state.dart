import 'package:equatable/equatable.dart';
import 'package:pdf_reader/shared/enums/state.dart';
import 'package:pdf_reader/shared/models/models.dart';

class PrivateFolderState extends Equatable {
  const PrivateFolderState({
    this.status = State.initial,
    this.message = '',
    this.privatePdfs = const [],
    this.pdfViewType = 0,
  });
  final State status;
  final String message;
  final List<PDF> privatePdfs;
  final int pdfViewType;

  PrivateFolderState copyWith({
    State? status,
    String? message,
    List<PDF>? privatePdfs,
    int? pdfViewType,
  }) {
    return PrivateFolderState(
      status: status ?? this.status,
      message: message ?? this.message,
      privatePdfs: privatePdfs ?? this.privatePdfs,
      pdfViewType: pdfViewType ?? this.pdfViewType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    privatePdfs,
    pdfViewType,
  ];
}
