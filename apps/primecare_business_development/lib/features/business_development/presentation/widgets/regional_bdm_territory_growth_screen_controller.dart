// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmTerritoryGrowthScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmTerritoryGrowthScreenControllerProvider =
    NotifierProvider<
      RegionalBdmTerritoryGrowthScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmTerritoryGrowthScreenController();
    });

class RegionalBdmTerritoryGrowthScreenController
    extends BaseScaffoldController {}
