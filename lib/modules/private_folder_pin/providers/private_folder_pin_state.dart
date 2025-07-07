import 'package:equatable/equatable.dart';
import 'package:pdf_reader/shared/enums/state.dart';

class PrivateFolderPinState extends Equatable {
  const PrivateFolderPinState({
    this.status = State.initial,
    this.message = '',
    this.pin = '',
    this.isPinSet = false,
    this.isVerified = false,
  });

  final State status;
  final String message;
  final String pin;
  final bool isPinSet;
  final bool isVerified;

  PrivateFolderPinState copyWith({
    State? status,
    String? message,
    String? pin,
    bool? isPinSet,
    bool? isVerified,
  }) {
    return PrivateFolderPinState(
      status: status ?? this.status,
      message: message ?? this.message,
      pin: pin ?? this.pin,
      isPinSet: isPinSet ?? this.isPinSet,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    pin,
    isPinSet,
    isVerified,
  ];
}
