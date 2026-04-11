import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart'; // Ensure DataFallbackEngine is accessible
import 'package:primecare_adapters/primecare_adapters.dart'; // Ensure DataLogisticsHub is accessible

final franchiseOwnerAdapterProvider = FutureProvider<FranchiseOwnerViewModel>((ref) async {
  return DataLogisticsHub.fetchAndAssemble<FranchiseOwnerViewModel>(
    fetchCall: () async {
      // Simulating realistic network fetch
      await Future.delayed(const Duration(milliseconds: 600));
      // Simulating a catastrophic API failure, like 502 Bad Gateway
      throw Exception('502 Bad Gateway: API is currently down');
      
      // In reality, this would just be:
      // final dto = await api.getFranchiseOwnerData();
      // return FranchiseOwnerMapper.fromApi(dto);
    },
    fallbackBuilder: () {
      // Rather than a blank screen or unhandled exception, emit graceful dummy data.
      return FranchiseOwnerViewModel(
        isOfflineFallback: true,
        blueprints: [
          DataFallbackEngine.createFallbackStatGrid('Franchise KPIs (Graceful Fallback)'),
          DataFallbackEngine.createFallbackActivityFeed('System Logs (Degraded Mode)'),
        ],
      );
    },
  );
});
