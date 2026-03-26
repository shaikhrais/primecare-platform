import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/roles/rn/models/rn_patient_model.dart';

final rnPatientsProvider = FutureProvider.autoDispose<List<RnPatientData>>((
  ref,
) async {
  final response = await apiClient.get('/v1/rn/patients');

  if (response is List) {
    return response.map((json) => RnPatientData.fromJson(json)).toList();
  } else {
    return [];
  }
});
