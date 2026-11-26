// Governance - Category: controller | Purpose: Non-executable scaffold for TerritoryExpansionManagerExpansionPlansScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territoryExpansionManagerExpansionPlansScreenControllerProvider =
    NotifierProvider<
      TerritoryExpansionManagerExpansionPlansScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritoryExpansionManagerExpansionPlansScreenController();
    });

class TerritoryExpansionManagerExpansionPlansScreenController
    extends BaseScaffoldController {}
