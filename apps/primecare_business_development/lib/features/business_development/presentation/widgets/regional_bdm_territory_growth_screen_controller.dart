// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmTerritoryGrowthScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalBdmTerritoryGrowthScreenControllerProvider =
    NotifierProvider<
      RegionalBdmTerritoryGrowthScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmTerritoryGrowthScreenController();
    });

class RegionalBdmTerritoryGrowthScreenController
    extends BaseScaffoldController {}
