// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorProviderAvailabilityScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final schedulerCoordinatorProviderAvailabilityScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorProviderAvailabilityScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorProviderAvailabilityScreenController();
    });

class SchedulerCoordinatorProviderAvailabilityScreenController
    extends BaseScaffoldController {}
