// Governance - Category: controller | Purpose: Non-executable scaffold for ClinicIncidentReportScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clinicIncidentReportScreenControllerProvider =
    NotifierProvider<
      ClinicIncidentReportScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClinicIncidentReportScreenController();
    });

class ClinicIncidentReportScreenController extends BaseScaffoldController {}
