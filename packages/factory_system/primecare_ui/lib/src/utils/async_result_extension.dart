// Layer: 01_INFRASTRUCTURE
import 'package:flutter/widgets.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import '../components/dashboards/dashboard_state_widgets.dart';

extension AsyncResultExtensions<S> on AsyncValue<Result<S>> {
  /// Unwraps both the AsyncValue and the Result in a single call.
  /// Optimized for Dashboards with resilient defaults.
  Widget whenResult(
    Widget Function(S data) data, {
    VoidCallback? onRetry,
    Widget Function()? loading,
    Widget Function(Object error, StackTrace st)? error,
  }) {
    return when(
      data: (result) => result.fold(
        (value) => data(value),
        (err) =>
            error?.call(err, StackTrace.current) ??
            DashboardErrorWidget(message: err.toString(), onRetry: onRetry),
      ),
      loading: loading ?? () => const DashboardLoadingWidget(),
      error: (err, st) =>
          error?.call(err, st) ??
          DashboardErrorWidget(message: err.toString(), onRetry: onRetry),
    );
  }
}
