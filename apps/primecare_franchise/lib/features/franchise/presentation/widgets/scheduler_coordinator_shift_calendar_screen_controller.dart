// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorShiftCalendarScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final schedulerCoordinatorShiftCalendarScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorShiftCalendarScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorShiftCalendarScreenController();
    });

class SchedulerCoordinatorShiftCalendarScreenController
    extends BaseScaffoldController {}
