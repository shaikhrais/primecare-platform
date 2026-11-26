// Governance - Category: controller | Purpose: Non-executable scaffold for CooBranchComparisonScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cooBranchComparisonScreenControllerProvider =
    NotifierProvider<
      CooBranchComparisonScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooBranchComparisonScreenController();
    });

class CooBranchComparisonScreenController extends BaseScaffoldController {}
