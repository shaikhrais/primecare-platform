// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerDashboardScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerDashboardScreenController();
    });

class ComplianceManagerDashboardScreenController
    extends BaseScaffoldController {}
