import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfThemeProvider extends AutoDisposeAsyncNotifier<bool> {
  SharedPreferences? _prefs;
  @override
  Future<bool> build() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs?.getBool('pdf_theme') ?? false;
  }

  Future<void> toggleTheme(bool value) async {
    await _prefs?.setBool('pdf_theme', value);
    state = AsyncValue.data(value);
  }
}
