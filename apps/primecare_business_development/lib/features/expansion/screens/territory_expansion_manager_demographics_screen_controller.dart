// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerDemographicsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territoryExpansionManagerDemographicsScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerDemographicsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerDemographicsScreenController();
    });

class TerritoryExpansionManagerDemographicsScreenController
    extends BaseScaffoldController {}
