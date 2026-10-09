// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorBookingRequestsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final schedulerCoordinatorBookingRequestsScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorBookingRequestsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorBookingRequestsScreenController();
    });

class SchedulerCoordinatorBookingRequestsScreenController
    extends BaseScaffoldController {}
