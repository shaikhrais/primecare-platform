import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final trainingCoordinatorDashboardAdapterProvider =
    FutureProvider<TrainingCoordinatorDashboardViewModel>((ref) async {
      return DataLogisticsHub.fetchAndAssemble<
        TrainingCoordinatorDashboardViewModel
      >(
        fetchCall: () async {
          final apiClient = ref.read(apiClientProvider);
          final endpoint = '/api/v1/metrics';
          final response = await apiClient.get('$endpoint?route=UnknownRoute');

          if (response.statusCode == 200) {
            return TrainingCoordinatorDashboardViewModel(
              blueprints: [
                DataFallbackEngine.createFallbackStatGrid('Live Dashboard'),
                DataFallbackEngine.createFallbackActivityFeed('System Logs'),
              ],
            );
          } else {
            throw Exception(
              'API error loading dashboard: ${response.statusCode}',
            );
          }
        },
        fallbackBuilder: () {
          return TrainingCoordinatorDashboardViewModel(
            isOfflineFallback: true,
            blueprints: [
              DataFallbackEngine.createFallbackStatGrid('Offline Dashboard'),
              DataFallbackEngine.createFallbackActivityFeed(
                'System Logs (Degraded)',
              ),
            ],
          );
        },
      );
    });
