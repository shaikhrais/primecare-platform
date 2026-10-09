// Governance - Category: controller | Purpose: Non-executable scaffold for PatientProfileScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final patientProfileScreenControllerProvider =
    NotifierProvider<
      PatientProfileScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientProfileScreenController();
    });

class PatientProfileScreenController extends BaseScaffoldController {}
