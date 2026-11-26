// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territoryExpansionManagerReportsScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerReportsScreenController();
    });

class TerritoryExpansionManagerReportsScreenController
    extends BaseScaffoldController {}
