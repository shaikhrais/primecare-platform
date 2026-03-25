import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/coordinator/models/coordinator_stats_model.dart';

final coordinatorStatsProvider = FutureProvider.autoDispose<CoordinatorStatsData>((
  ref,
) async {
  final response = await apiClient.get('/api/coordinator/home/stats');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return CoordinatorStatsData.fromJson(data);
  } else {
    throw Exception(
      'Failed to load Coordinator Hub Stats natively. Status: ${response.statusCode}',
    );
  }
});
