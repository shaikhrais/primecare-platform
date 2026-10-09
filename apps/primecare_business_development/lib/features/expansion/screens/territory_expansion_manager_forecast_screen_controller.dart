// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerForecastScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territoryExpansionManagerForecastScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerForecastScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerForecastScreenController();
    });

class TerritoryExpansionManagerForecastScreenController
    extends BaseScaffoldController {}
