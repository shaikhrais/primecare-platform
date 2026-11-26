// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerMarketResearchScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territoryExpansionManagerMarketResearchScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerMarketResearchScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerMarketResearchScreenController();
    });

class TerritoryExpansionManagerMarketResearchScreenController
    extends BaseScaffoldController {}
