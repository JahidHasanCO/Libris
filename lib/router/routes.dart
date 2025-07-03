part of 'router.dart';

sealed class Routes {
  static const onboard = 'onboard';
  static const bottomNavigation = 'bottom_navigation';
}

extension AsPathExt on String {
  String get asPath => '/$this';
}
