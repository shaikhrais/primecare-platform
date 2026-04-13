import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

final franchiseOwnerAdapterProvider = FutureProvider<FranchiseOwnerViewModel>((ref) async {
  return DataLogisticsHub.fetchAndAssemble<FranchiseOwnerViewModel>(
    fetchCall: () async {
      final apiClient = ref.read(apiClientProvider);
      final endpoint = '/api/v1/metrics';
      final response = await apiClient.get('$endpoint?route=UnknownRoute');

      if (response.statusCode == 200) {
        return FranchiseOwnerViewModel(
          blueprints: [
            DataFallbackEngine.createFallbackStatGrid('Live Dashboard'),
            DataFallbackEngine.createFallbackActivityFeed('System Logs'),
          ],
        );
      } else {
        throw Exception('API error loading dashboard: ${response.statusCode}');
      }
    },
    fallbackBuilder: () {
      return FranchiseOwnerViewModel(
        isOfflineFallback: true,
        blueprints: [
          DataFallbackEngine.createFallbackStatGrid('Offline Dashboard'),
          DataFallbackEngine.createFallbackActivityFeed('System Logs (Degraded)'),
        ],
      );
    },
  );
});
