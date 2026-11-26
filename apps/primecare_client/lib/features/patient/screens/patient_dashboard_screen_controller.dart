// Governance - Category: controller | Purpose: Non-executable scaffold for PatientDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final patientDashboardScreenControllerProvider =
    NotifierProvider<
      PatientDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PatientDashboardScreenController();
    });

class PatientDashboardScreenController extends BaseScaffoldController {}
