// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territoryExpansionManagerReportsScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerReportsScreenController();
    });

class TerritoryExpansionManagerReportsScreenController
    extends BaseScaffoldController {}
