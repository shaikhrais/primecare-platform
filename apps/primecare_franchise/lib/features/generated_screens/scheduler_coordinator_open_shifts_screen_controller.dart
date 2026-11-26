// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorOpenShiftsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final schedulerCoordinatorOpenShiftsScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorOpenShiftsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorOpenShiftsScreenController();
    });

class SchedulerCoordinatorOpenShiftsScreenController
    extends BaseScaffoldController {}
