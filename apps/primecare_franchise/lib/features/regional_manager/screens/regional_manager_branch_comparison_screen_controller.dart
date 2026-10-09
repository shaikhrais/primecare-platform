// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalManagerBranchComparisonScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalManagerBranchComparisonScreenControllerProvider =
    NotifierProvider<
      RegionalManagerBranchComparisonScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalManagerBranchComparisonScreenController();
    });

class RegionalManagerBranchComparisonScreenController
    extends BaseScaffoldController {}
