// Governance - Category: controller | Purpose: Non-executable scaffold for BillingAdminDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final billingAdminDashboardScreenControllerProvider =
    NotifierProvider<
      BillingAdminDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return BillingAdminDashboardScreenController();
    });

class BillingAdminDashboardScreenController extends BaseScaffoldController {}
