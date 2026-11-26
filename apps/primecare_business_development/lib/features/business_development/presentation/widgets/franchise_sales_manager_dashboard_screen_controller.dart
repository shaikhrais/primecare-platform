// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseSalesManagerDashboardScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerDashboardScreenController();
    });

class FranchiseSalesManagerDashboardScreenController
    extends BaseScaffoldController {}
