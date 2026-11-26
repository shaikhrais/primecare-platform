// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerSiteSelectionScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territoryExpansionManagerSiteSelectionScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerSiteSelectionScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerSiteSelectionScreenController();
    });

class TerritoryExpansionManagerSiteSelectionScreenController
    extends BaseScaffoldController {}
