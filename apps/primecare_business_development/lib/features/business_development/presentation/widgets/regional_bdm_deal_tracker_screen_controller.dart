// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmDealTrackerScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmDealTrackerScreenControllerProvider =
    NotifierProvider<
      RegionalBdmDealTrackerScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmDealTrackerScreenController();
    });

class RegionalBdmDealTrackerScreenController extends BaseScaffoldController {}
