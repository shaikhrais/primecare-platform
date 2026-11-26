// Governance - Category: controller | Purpose: Non-executable scaffold for IncidentReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final incidentReportsScreenControllerProvider =
    NotifierProvider<
      IncidentReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IncidentReportsScreenController();
    });

class IncidentReportsScreenController extends BaseScaffoldController {}
