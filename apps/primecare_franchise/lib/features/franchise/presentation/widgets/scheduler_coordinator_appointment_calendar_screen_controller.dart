// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorAppointmentCalendarScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final schedulerCoordinatorAppointmentCalendarScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorAppointmentCalendarScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorAppointmentCalendarScreenController();
    });

class SchedulerCoordinatorAppointmentCalendarScreenController
    extends BaseScaffoldController {}
