// Governance - Category: controller | Purpose: Non-executable scaffold for BillingAdminDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final billingAdminDashboardScreenControllerProvider =
    NotifierProvider<
      BillingAdminDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return BillingAdminDashboardScreenController();
    });

class BillingAdminDashboardScreenController extends BaseScaffoldController {}
