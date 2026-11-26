// Governance - Category: controller | Purpose: Non-executable scaffold for PatientTreatmentHistoryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final patientTreatmentHistoryScreenControllerProvider =
    NotifierProvider<
      PatientTreatmentHistoryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientTreatmentHistoryScreenController();
    });

class PatientTreatmentHistoryScreenController extends BaseScaffoldController {}
