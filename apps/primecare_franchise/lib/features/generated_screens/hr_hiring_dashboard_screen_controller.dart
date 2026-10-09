// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrHiringDashboardScreenControllerProvider =
    NotifierProvider<
      HrHiringDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringDashboardScreenController();
    });

class HrHiringDashboardScreenController extends BaseScaffoldController {}
