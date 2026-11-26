// Governance - Category: controller | Purpose: Non-executable scaffold for PatientProfileScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final patientProfileScreenControllerProvider =
    NotifierProvider<
      PatientProfileScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientProfileScreenController();
    });

class PatientProfileScreenController extends BaseScaffoldController {}
