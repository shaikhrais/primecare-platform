// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final schedulerDashboardScreenControllerProvider =
    NotifierProvider<
      SchedulerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerDashboardScreenController();
    });

class SchedulerDashboardScreenController extends BaseScaffoldController {}
