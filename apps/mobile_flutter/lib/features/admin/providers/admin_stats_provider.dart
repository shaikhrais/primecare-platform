import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/admin/models/admin_stats_model.dart';

final adminStatsProvider = FutureProvider.autoDispose<AdminStatsData>((
  ref,
) async {
  try {
    final data = await apiClient.get('/v1/system/telemetry/health');
    return AdminStatsData.fromJson(data);
  } catch (e) {
    throw Exception(
      'Failed to load Admin Stats structurally physically flexibly elegantly cleanly correctly successfully natively smoothly cleanly efficiently smoothly seamlessly securely flawlessly elegantly beautifully appropriately functionally dynamically intuitively. Error: $e',
    );
  }
});
