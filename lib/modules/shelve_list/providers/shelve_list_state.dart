import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/models.dart';

class ShelveListState extends Equatable {
  const ShelveListState({
    this.status = State.initial,
    this.message = '',
    this.shelveList = const [],
  });
  final State status;
  final String message;
  final List<Shelf> shelveList;

  ShelveListState copyWith({
    State? status,
    String? message,
    List<Shelf>? shelveList,
  }) {
    return ShelveListState(
      status: status ?? this.status,
      message: message ?? this.message,
      shelveList: shelveList ?? this.shelveList,
    );
  }

  @override
  List<Object?> get props => [status, message, shelveList];
}
