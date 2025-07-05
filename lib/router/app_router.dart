part of 'router.dart';

final class AppRouter {
  factory AppRouter({String? initialLocation}) =>
      initialLocation == _instance?.initialLocation
      ? _instance ??= AppRouter._(initialLocation: initialLocation)
      : _instance = AppRouter._(initialLocation: initialLocation);

  AppRouter._({this.initialLocation})
    : config = GoRouter(
        routes: _routes ??= <RouteBase>[
          BottomNavigationPage.route,
          OnboardPage.route,
          PdfAddPage.route,
        ],
        navigatorKey: navigatorKey,
        initialLocation: initialLocation,
        errorBuilder: (context, state) => const ErrorPage(),
        debugLogDiagnostics: kDebugMode,
        observers: [NavigationHistoryObserver()],
      );

  static AppRouter? _instance;
  final String? initialLocation;
  static List<RouteBase>? _routes;
  final GoRouter config;
}

Future<dynamic>? globalPushNamed(String path, {Object? extra}) {
  return navigatorKey.currentContext?.pushNamed(path, extra: extra);
}

void globalGo(String path, {Object? extra}) {
  navigatorKey.currentContext?.go(path, extra: extra);
}

void globalPushReplacementNamed(String path, {Object? extra}) {
  navigatorKey.currentContext?.pushReplacementNamed(path, extra: extra);
}
