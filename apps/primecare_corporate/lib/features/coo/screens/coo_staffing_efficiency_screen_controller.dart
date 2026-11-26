// Governance - Category: controller | Purpose: Non-executable scaffold for CooStaffingEfficiencyScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooStaffingEfficiencyScreenControllerProvider =
    NotifierProvider<
      CooStaffingEfficiencyScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooStaffingEfficiencyScreenController();
    });

class CooStaffingEfficiencyScreenController extends BaseScaffoldController {}
