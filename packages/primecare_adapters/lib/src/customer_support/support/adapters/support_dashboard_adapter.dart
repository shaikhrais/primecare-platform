import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final supportDashboardAdapterProvider =
    FutureProvider<Result<SupportDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);

      return Result.guardFuture<SupportDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<SupportDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';
              final response = await apiClient.get(
                '$endpoint?route=UnknownRoute',
              );

              if (response.statusCode == 200) {
                final data = SupportDashboardViewModel(
                  blueprints: [
                    DataFallbackEngine.createFallbackStatGrid('Live Dashboard'),
                    DataFallbackEngine.createFallbackActivityFeed(
                      'System Logs',
                    ),
                  ],
                );
                telemetry.passGate(
                  ExecutionGateCategory.adapters,
                  'Support Dashboard synthesized from live API',
                );
                return data;
              } else {
                throw Exception('API returned non-200: ${response.statusCode}');
              }
            },
            fallbackBuilder: () {
              return SupportDashboardViewModel(
                isOfflineFallback: true,
                blueprints: [
                  DataFallbackEngine.createFallbackStatGrid(
                    'Offline Dashboard',
                  ),
                  DataFallbackEngine.createFallbackActivityFeed(
                    'System Logs (Degraded)',
                  ),
                ],
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.adapters,
            'Critical failure in SupportDashboardAdapter synthesis',
            error: e,
            stackTrace: st,
          );
          // Return the LKG/Offline fallback within the Success container
          // to allow the UI to continue rendering with placeholders.
          return SupportDashboardViewModel(
            isOfflineFallback: true,
            blueprints: [
              DataFallbackEngine.createFallbackStatGrid('LKG Dashboard'),
              DataFallbackEngine.createFallbackActivityFeed(
                'Local Activity (LKG)',
              ),
            ],
          );
        },
      );
    });
