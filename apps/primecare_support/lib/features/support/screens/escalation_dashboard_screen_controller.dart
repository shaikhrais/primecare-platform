// Governance - Category: controller | Purpose: Non-executable scaffold for EscalationDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final escalationDashboardScreenControllerProvider =
    NotifierProvider<
      EscalationDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return EscalationDashboardScreenController();
    });

class EscalationDashboardScreenController extends BaseScaffoldController {}
