import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/models.dart';

class ShelveDetailsState extends Equatable {
  const ShelveDetailsState({
    required this.shelf,
    this.status = State.initial,
    this.message = '',
    this.pdfList = const [],
    this.insertAblePdfList = const [],
    this.pdfViewType = 0,
  });

  final State status;
  final String message;
  final Shelf shelf;
  final List<PDF> pdfList;
  final List<PDF> insertAblePdfList;
  final int pdfViewType;

  ShelveDetailsState copyWith({
    State? status,
    String? message,
    Shelf? shelf,
    List<PDF>? pdfList,
    List<PDF>? insertAblePdfList,
    int? pdfViewType,
  }) {
    return ShelveDetailsState(
      status: status ?? this.status,
      message: message ?? this.message,
      pdfList: pdfList ?? this.pdfList,
      shelf: shelf ?? this.shelf,
      insertAblePdfList: insertAblePdfList ?? this.insertAblePdfList,
      pdfViewType: pdfViewType ?? this.pdfViewType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    shelf,
    pdfList,
    insertAblePdfList,
    pdfViewType,
  ];
}
