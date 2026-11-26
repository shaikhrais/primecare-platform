// Governance - Category: controller | Purpose: Non-executable scaffold for CooStaffingEfficiencyScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cooStaffingEfficiencyScreenControllerProvider =
    NotifierProvider<
      CooStaffingEfficiencyScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooStaffingEfficiencyScreenController();
    });

class CooStaffingEfficiencyScreenController extends BaseScaffoldController {}
