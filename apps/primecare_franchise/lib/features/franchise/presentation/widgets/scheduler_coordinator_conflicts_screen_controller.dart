// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorConflictsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final schedulerCoordinatorConflictsScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorConflictsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorConflictsScreenController();
    });

class SchedulerCoordinatorConflictsScreenController
    extends BaseScaffoldController {}
