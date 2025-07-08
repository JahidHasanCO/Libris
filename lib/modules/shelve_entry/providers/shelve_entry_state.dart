import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:libris/shared/models/models.dart';

class ShelveEntryState extends Equatable {
  const ShelveEntryState({
    this.status = State.initial,
    this.message = '',
  });
  final State status;
  final String message;

  ShelveEntryState copyWith({
    State? status,
    String? message,
    Shelf? shelf,
  }) {
    return ShelveEntryState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
  ];
}
