// Governance - Category: controller | Purpose: Non-executable scaffold for PatientPaymentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final patientPaymentsScreenControllerProvider =
    NotifierProvider<
      PatientPaymentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientPaymentsScreenController();
    });

class PatientPaymentsScreenController extends BaseScaffoldController {}
