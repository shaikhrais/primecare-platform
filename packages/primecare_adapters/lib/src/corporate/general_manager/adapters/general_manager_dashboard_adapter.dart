// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'dart:async';
import 'package:primecare_core/primecare_core.dart';

final generalManagerDashboardAdapterProvider =
    FutureProvider<Result<GeneralManagerDashboardViewModel>>((ref) async {
      const route = 'GeneralManager';
      const cacheKey = 'general_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);

      // High-performance concurrent fetch for metrics and AI analytics
      final results = await Future.wait([
        ref.watch(dashboardMetricsProvider(route).future),
        ref.watch(aiAnalyticsForecastingProvider.future),
      ]);

      final metricsResult = results[0] as Result<DashboardMetrics>;
      final aiResult = results[1] as Result<AIAnalyticsForecastingData>;

      return metricsResult.fold(
        (metrics) {
          final forecasting = aiResult.fold((data) => data, (err) => null);
          final viewModel =
              GeneralManagerDashboardViewModel.fromDashboardMetrics(
                metrics,
                forecasting: forecasting,
              );
          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
          return Success(viewModel);
        },
        (error) {
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(GeneralManagerDashboardViewModel.fromJson(snapshot));
          }
          return Success(
            GeneralManagerDashboardViewModel.assemble(isOffline: true),
          );
        },
      );
    });
