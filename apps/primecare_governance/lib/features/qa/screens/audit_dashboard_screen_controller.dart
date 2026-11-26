// Governance - Category: controller | Purpose: Non-executable scaffold for AuditDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final auditDashboardScreenControllerProvider =
    NotifierProvider<
      AuditDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AuditDashboardScreenController();
    });

class AuditDashboardScreenController extends BaseScaffoldController {}
