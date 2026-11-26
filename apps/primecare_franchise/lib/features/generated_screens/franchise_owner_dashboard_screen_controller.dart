// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseOwnerDashboardScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerDashboardScreenController();
    });

class FranchiseOwnerDashboardScreenController extends BaseScaffoldController {}
