// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmDealTrackerScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalBdmDealTrackerScreenControllerProvider =
    NotifierProvider<
      RegionalBdmDealTrackerScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmDealTrackerScreenController();
    });

class RegionalBdmDealTrackerScreenController extends BaseScaffoldController {}
