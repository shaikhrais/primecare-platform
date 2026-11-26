// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerDashboardScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerDashboardScreenController();
    });

class FranchiseOwnerDashboardScreenController extends BaseScaffoldController {}
