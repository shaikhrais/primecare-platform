// Governance - Category: controller | Purpose: Non-executable scaffold for SchedulerCoordinatorProviderAvailabilityScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final schedulerCoordinatorProviderAvailabilityScreenControllerProvider =
    NotifierProvider<
      SchedulerCoordinatorProviderAvailabilityScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SchedulerCoordinatorProviderAvailabilityScreenController();
    });

class SchedulerCoordinatorProviderAvailabilityScreenController
    extends BaseScaffoldController {}
