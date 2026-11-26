// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerOpenTerritoriesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territoryExpansionManagerOpenTerritoriesScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerOpenTerritoriesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerOpenTerritoriesScreenController();
    });

class TerritoryExpansionManagerOpenTerritoriesScreenController
    extends BaseScaffoldController {}
