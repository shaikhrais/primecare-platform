// Governance - Category: controller | Purpose: Non-executable scaffold for PatientCareTeamScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final patientCareTeamScreenControllerProvider =
    NotifierProvider<
      PatientCareTeamScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientCareTeamScreenController();
    });

class PatientCareTeamScreenController extends BaseScaffoldController {}
