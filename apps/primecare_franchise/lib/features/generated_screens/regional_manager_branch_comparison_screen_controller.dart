// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalManagerBranchComparisonScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalManagerBranchComparisonScreenControllerProvider =
    NotifierProvider<
      RegionalManagerBranchComparisonScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalManagerBranchComparisonScreenController();
    });

class RegionalManagerBranchComparisonScreenController
    extends BaseScaffoldController {}
