// Governance - Category: controller | Purpose: Non-executable scaffold for PatientMyAppointmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final patientMyAppointmentsScreenControllerProvider =
    NotifierProvider<
      PatientMyAppointmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientMyAppointmentsScreenController();
    });

class PatientMyAppointmentsScreenController extends BaseScaffoldController {}
