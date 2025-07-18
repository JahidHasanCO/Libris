import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/modules/private_folder_pin/private_folder_pin.dart';
import 'package:libris/shared/enums/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivateFolderPinProvider
    extends AutoDisposeNotifier<PrivateFolderPinState> {
  SharedPreferences? _prefs;

  @override
  PrivateFolderPinState build() {
    return const PrivateFolderPinState();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final pin = _prefs?.getString('private_folder_pin') ?? '';
    final isPinSet = pin.isNotEmpty;
    state = PrivateFolderPinState(pin: pin, isPinSet: isPinSet);
  }

  Future<void> setPin(String pin) async {
    state = state.copyWith(status: State.loading, message: '');
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString('private_folder_pin', pin);
    state = state.copyWith(
      pin: pin,
      isPinSet: true,
      isVerified: false,
      status: State.success,
    );
  }

  void verifyPin(String pin) {
    state = state.copyWith(
      status: State.loading,
      message: '',
      isVerified: false,
    );
    if (state.pin == pin) {
      state = state.copyWith(
        isVerified: true,
        status: State.success,
      );
    } else {
      state = state.copyWith(
        isVerified: false,
        status: State.error,
        message: 'Pin verification failed',
      );
    }
  }
}
