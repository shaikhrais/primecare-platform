// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territoryExpansionManagerDashboardScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerDashboardScreenController();
    });

class TerritoryExpansionManagerDashboardScreenController
    extends BaseScaffoldController {}
