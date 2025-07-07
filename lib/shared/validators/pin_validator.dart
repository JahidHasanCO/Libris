mixin PinValidator {
  String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN cannot be empty';
    }
    if (value.length != 4) {
      return 'PIN must be exactly 4 digits';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'PIN must contain only digits';
    }
    return null;
  }

  String? validatePinConfirmation(String? value, String pin) {
    if (value == null || value.isEmpty) {
      return 'PIN confirmation cannot be empty';
    }
    if (value != pin) {
      return 'PINs do not match';
    }
    return null;
  }
}
