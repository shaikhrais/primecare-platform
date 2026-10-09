// Governance - Category: controller | Purpose: Non-executable scaffold for PatientPaymentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final patientPaymentsScreenControllerProvider =
    NotifierProvider<
      PatientPaymentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientPaymentsScreenController();
    });

class PatientPaymentsScreenController extends BaseScaffoldController {}
