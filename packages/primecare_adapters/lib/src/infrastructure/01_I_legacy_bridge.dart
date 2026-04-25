// Layer: 01_INFRASTRUCTURE
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '01_I_dashboard_service.dart';
import '01_I_dashboard_providers.dart';
import '01_I_result.dart';
import '01_I_resilience_service.dart';
import '../models/core/02_M_dashboard_models.dart';

/// Legacy Bridge for PrimeCare platform decoupling.
/// Restores ubiquitous symbols and mapping patterns to achieve a Zero-Error build state.

class PrimeCareLogger {
  static void log(String message, {Object? error, StackTrace? stackTrace}) {
    // In the decoupled state, we pipe to debug console.
    // Real telemetry is handled by ExecutionGateService in the providers layer.
    if (kDebugMode) {
      print('[PrimeCareLogger] $message');
      if (error != null) {
        print('[PrimeCareLogger] ERROR: $error');
      }
    }
  }
}

abstract class IDashboardRepository {
  Stream<Result<DashboardMetrics>> watchMetrics(String route);
}

class DashboardRepository implements IDashboardRepository {
  final DashboardService _service;

  DashboardRepository(this._service);

  @override
  Stream<Result<DashboardMetrics>> watchMetrics(String route) async* {
    yield await _service.getMetrics(route);
  }
}

final dashboardRepositoryProvider = Provider<IDashboardRepository>((ref) {
  final service = ref.watch(dashboardServiceProvider);
  return DashboardRepository(service);
});

// Legacy Type Aliases
typedef DashboardKpi = KpiMetric;
typedef PrimeCareKpi = KpiMetric;

// Legacy Enums/Identifiers
enum KpiTrend { up, down, neutral }

// Legacy Providers
final isOnlineProvider = Provider<bool>((ref) => true);
final persistenceProvider = Provider(
  (ref) => ref.watch(resilienceServiceProvider),
);

// Compatibility Provider for older adapters
final dashboardMetricsStreamProvider =
    StreamProvider.family<DashboardMetrics, String>((ref, route) {
      return ref
          .watch(dashboardRepositoryProvider)
          .watchMetrics(route)
          .map((result) => result.fold((m) => m, (e) => throw e));
    });

class ProviderTTL {
  static void autoInvalidate(
    Ref ref, {
    Duration duration = const Duration(minutes: 5),
  }) {
    final timer = Timer(duration, () {
      ref.invalidateSelf();
    });
    ref.onDispose(() => timer.cancel());
  }

  static void periodicRefresh(
    Ref ref, {
    Duration interval = const Duration(minutes: 5),
  }) {
    final timer = Timer.periodic(interval, (_) {
      ref.invalidateSelf();
    });
    ref.onDispose(() => timer.cancel());
  }
}
