import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/roles/psw/models/psw_dashboard_model.dart';

final pswDashboardProvider = FutureProvider.autoDispose<PswDashboardData>((
  ref,
) async {
  // Leverage the global apiClient injected across the application
  final response = await apiClient.get('/v1/psw/home');

  if (response != null) {
    return PswDashboardData.fromJson(response);
  } else {
    throw Exception(
      'Failed to load dashboard payload dynamically.',
    );
  }
});
