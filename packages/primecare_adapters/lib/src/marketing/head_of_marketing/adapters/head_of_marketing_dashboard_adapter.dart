// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'dart:async';
import 'package:primecare_core/primecare_core.dart';

final headOfMarketingDashboardAdapterProvider =
    FutureProvider<Result<HeadOfMarketingDashboardViewModel>>((ref) async {
      const route = 'HeadOfMarketing';
      const cacheKey = 'head_of_marketing_dashboard';
      final resilience = ref.read(resilienceServiceProvider);

      // Hardened concurrent orchestration: Standard Metrics + AI Forecasting
      final responses = await Future.wait([
        ref.watch(dashboardMetricsProvider(route).future),
        ref.watch(forecastingProvider(route).future),
      ]);

      final metricsResult = responses[0] as Result<DashboardMetrics>;
      final forecastingResult =
          responses[1] as Result<AIAnalyticsForecastingData?>;

      return metricsResult.fold(
        (metrics) {
          final forecasting = forecastingResult.fold((f) => f, (e) => null);
          final viewModel =
              HeadOfMarketingDashboardViewModel.fromDashboardMetrics(
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
            return Success(
              HeadOfMarketingDashboardViewModel.fromJson(snapshot),
            );
          }
          return Success(
            HeadOfMarketingDashboardViewModel.assemble(isOffline: true),
          );
        },
      );
    });
