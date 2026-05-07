import 'dart:async';
import 'package:flutter_core/flutter_core.dart';

final pswDashboardProvider = FutureProvider.autoDispose<Result<PswDashboardData>>((
  ref,
) async {
  // Section 9: Provider TTL - Auto-invalidate after 5 minutes to prevent stale data
  ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  const cacheKey = 'psw_dashboard_snapshot';

  // Section 8: Connectivity Awareness - Fast-fail if offline to avoid timeouts
  final isOnline = ref.watch(isOnlineProvider);
  if (!isOnline) {
    return await _handlePswFallback(resilience, cacheKey, telemetry, 'Offline');
  }

  final service = ref.watch(pswServiceProvider);

  try {
    final result = await service.getDashboardData();
    return result.fold(
      (data) {
        unawaited(resilience.saveSnapshot(cacheKey, data.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'PSW Dashboard hydrated successfully',
        );
        return Success(data);
      },
      (error) async {
        return await _handlePswFallback(resilience, cacheKey, telemetry, error);
      },
    );
  } catch (e) {
    return await _handlePswFallback(resilience, cacheKey, telemetry, e);
  }
});

Future<Result<PswDashboardData>> _handlePswFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
  dynamic error,
) async {
  telemetry.failGate(
    ExecutionGateCategory.domainApi,
    'PSW Dashboard hydration failed, attempting fallback',
    error: error,
  );

  final snapshot = await resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    return Success(PswDashboardData.fromJson(snapshot));
  }

  // Return empty state if no cache
  return Success(
    const PswDashboardData(
      stats: {},
      shiftProgress: 0.0,
      shiftDurationRemaining: '0h 0m',
      clients: [],
      tasks: [],
      monthlyCompletedTasks: 0,
      nextReviewDate: 'TBD',
    ),
  );
}
