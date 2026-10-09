// Governance - Category: controller | Purpose: Non-executable scaffold for PswIncidentReportScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswIncidentReportScreenControllerProvider =
    NotifierProvider<
      PswIncidentReportScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswIncidentReportScreenController();
    });

class PswIncidentReportScreenController extends BaseScaffoldController {}
