// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final schedulerDashboardScreenControllerProvider =
    NotifierProvider<
      SchedulerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerDashboardScreenController();
    });

class SchedulerDashboardScreenController extends BaseScaffoldController {}
