// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territoryExpansionManagerDashboardScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerDashboardScreenController();
    });

class TerritoryExpansionManagerDashboardScreenController
    extends BaseScaffoldController {}
