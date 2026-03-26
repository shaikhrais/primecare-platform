import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/roles/rn/models/rn_patient_model.dart';

final rnPatientsProvider = FutureProvider.autoDispose<List<RnPatientData>>((
  ref,
) async {
  final response = await apiClient.get('/api/rn/patients');

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => RnPatientData.fromJson(json)).toList();
  } else {
    throw Exception(
      'Failed to load RN Patients natively. Status: ${response.statusCode}',
    );
  }
});
