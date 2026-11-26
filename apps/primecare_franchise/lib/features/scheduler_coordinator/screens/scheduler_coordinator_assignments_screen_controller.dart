// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorAssignmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final schedulerCoordinatorAssignmentsScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorAssignmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorAssignmentsScreenController();
    });

class SchedulerCoordinatorAssignmentsScreenController
    extends BaseScaffoldController {}
