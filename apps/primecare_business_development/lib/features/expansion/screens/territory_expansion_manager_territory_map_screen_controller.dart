// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerTerritoryMapScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territoryExpansionManagerTerritoryMapScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerTerritoryMapScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerTerritoryMapScreenController();
    });

class TerritoryExpansionManagerTerritoryMapScreenController
    extends BaseScaffoldController {}
