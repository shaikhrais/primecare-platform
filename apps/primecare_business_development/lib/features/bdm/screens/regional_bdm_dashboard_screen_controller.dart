// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmDashboardScreenControllerProvider =
    NotifierProvider<
      RegionalBdmDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmDashboardScreenController();
    });

class RegionalBdmDashboardScreenController extends BaseScaffoldController {}
