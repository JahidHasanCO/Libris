import 'package:equatable/equatable.dart';
import 'package:libris/shared/enums/enums.dart';
import 'package:libris/shared/models/models.dart';

class OnboardState extends Equatable {
  const OnboardState({
    this.status = State.initial,
    this.message = '',
    this.onboardList = const [],
    this.currentIndex = 0,
  });
  final State status;
  final String message;
  final List<Onboard> onboardList;
  final int currentIndex;

  OnboardState copyWith({
    State? status,
    String? message,
    List<Onboard>? onboardList,
    int? currentIndex,
  }) {
    return OnboardState(
      status: status ?? this.status,
      message: message ?? this.message,
      onboardList: onboardList ?? this.onboardList,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [status, message, onboardList, currentIndex];
}
