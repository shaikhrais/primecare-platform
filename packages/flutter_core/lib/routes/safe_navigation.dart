import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// An extension type that enforces strictly-defined routes at compile time.
/// This prevents raw string navigation like `context.go('/typo-path')`.
extension type const AppRoute(String path) {
  /// Allows route definitions that append parameter paths dynamically
  AppRoute withParams(Map<String, String> params) {
    if (params.isEmpty) return this;
    var result = path;
    for (final entry in params.entries) {
      result = result.replaceAll(':${entry.key}', entry.value);
    }
    return AppRoute(result);
  }
}

/// Helper extension to expose safe navigation methods on [BuildContext].
extension SafeNavigation on BuildContext {
  /// Safely navigates using a compiled [AppRoute].
  void goSafe(AppRoute route, {Object? extra}) => go(route.path, extra: extra);

  /// Safely pushes using a compiled [AppRoute].
  void pushSafe(AppRoute route, {Object? extra}) => push(route.path, extra: extra);

  /// Safely replaces current route using a compiled [AppRoute].
  void pushReplacementSafe(AppRoute route, {Object? extra}) =>
      pushReplacement(route.path, extra: extra);
}
