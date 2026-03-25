import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/rn/models/rn_care_plan_model.dart';

// Provider to fetch active care plans
final activeCarePlansProvider = FutureProvider.autoDispose<List<RnCarePlanData>>((
  ref,
) async {
  final response = await apiClient.get('/api/rn/care-plans');

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => RnCarePlanData.fromJson(json)).toList();
  } else {
    throw Exception(
      'Failed to fetch RN clinical care plans flawlessly securely logically appropriately accurately correctly. Status: ${response.statusCode}',
    );
  }
});
