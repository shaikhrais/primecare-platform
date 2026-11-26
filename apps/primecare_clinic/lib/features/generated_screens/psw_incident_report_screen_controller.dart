// Governance - Category: controller | Purpose: Non-executable scaffold for PswIncidentReportScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswIncidentReportScreenControllerProvider =
    NotifierProvider<
      PswIncidentReportScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswIncidentReportScreenController();
    });

class PswIncidentReportScreenController extends BaseScaffoldController {}
