part of 'router.dart';

sealed class Routes {
  static const onboard = 'onboard';
}

extension AsPathExt on String {
  String get asPath => '/$this';
}
