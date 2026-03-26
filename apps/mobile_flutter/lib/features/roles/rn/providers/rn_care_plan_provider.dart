import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/roles/rn/models/rn_care_plan_model.dart';

// Provider to fetch active care plans
final activeCarePlansProvider = FutureProvider.autoDispose<List<RnCarePlanData>>((
  ref,
) async {
  final response = await apiClient.get('/v1/rn/care-plans');

  if (response is List) {
    return response.map((json) => RnCarePlanData.fromJson(json)).toList();
  } else {
    return [];
  }
});
