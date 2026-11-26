// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorAppointmentCalendarScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final schedulerCoordinatorAppointmentCalendarScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorAppointmentCalendarScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorAppointmentCalendarScreenController();
    });

class SchedulerCoordinatorAppointmentCalendarScreenController
    extends BaseScaffoldController {}
