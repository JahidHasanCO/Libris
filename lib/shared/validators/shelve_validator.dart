mixin ShelveValidator {
  String? validateTitle(String? value) {
    if (value == null) return null;
    if (value.isEmpty) return 'Title cannot be empty';
    if (value.length < 3) return 'Title must be at least 3 characters long';
    if (value.length > 200) return 'Title must be less than 200 characters';
    return null;
  }
}
