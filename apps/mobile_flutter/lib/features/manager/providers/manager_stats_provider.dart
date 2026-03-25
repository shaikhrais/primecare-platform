import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/manager/models/manager_stats_model.dart';

final managerStatsProvider = FutureProvider.autoDispose<ManagerStatsData>((
  ref,
) async {
  final response = await apiClient.get('/api/manager/home/stats');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return ManagerStatsData.fromJson(data);
  } else {
    throw Exception(
      'Failed to load Manager Stats locally natively physically. Status: ${response.statusCode}',
    );
  }
});
