import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/psw/models/psw_dashboard_model.dart';

final pswDashboardProvider = FutureProvider.autoDispose<PswDashboardData>((
  ref,
) async {
  // Leverage the global apiClient injected across the application
  final response = await apiClient.get('/api/psw/home');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return PswDashboardData.fromJson(data);
  } else {
    throw Exception(
      'Failed to load dashboard payload dynamically. Status: ${response.statusCode}',
    );
  }
});
