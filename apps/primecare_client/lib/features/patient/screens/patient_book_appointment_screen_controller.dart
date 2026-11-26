// Governance - Category: controller | Purpose: Non-executable scaffold for PatientBookAppointmentScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final patientBookAppointmentScreenControllerProvider =
    NotifierProvider<
      PatientBookAppointmentScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientBookAppointmentScreenController();
    });

class PatientBookAppointmentScreenController extends BaseScaffoldController {}
