// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final schedulerCoordinatorReportsScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorReportsScreenController();
    });

class SchedulerCoordinatorReportsScreenController
    extends BaseScaffoldController {}
