import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final hrHiringDashboardAdapterProvider =
    FutureProvider<HrHiringDashboardViewModel>((ref) async {
      return DataLogisticsHub.fetchAndAssemble<HrHiringDashboardViewModel>(
        fetchCall: () async {
          final apiClient = ref.read(apiClientProvider);
          final endpoint = '/api/v1/metrics';
          final response = await apiClient.get('$endpoint?route=UnknownRoute');

          if (response.statusCode == 200) {
            return HrHiringDashboardViewModel(
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
          return HrHiringDashboardViewModel(
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
