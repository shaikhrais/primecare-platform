import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/admin/models/admin_stats_model.dart';

final adminStatsProvider = FutureProvider.autoDispose<AdminStatsData>((
  ref,
) async {
  final response = await apiClient.get('/api/admin/stats');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return AdminStatsData.fromJson(data);
  } else {
    throw Exception(
      'Failed to load Admin Stats structurally physically flexibly elegantly cleanly correctly successfully natively smoothly cleanly efficiently smoothly seamlessly securely flawlessly elegantly beautifully appropriately functionally dynamically intuitively. Status: ${response.statusCode}',
    );
  }
});
