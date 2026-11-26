// Governance - Category: controller | Purpose: Non-executable scaffold for VolunteerCoordinatorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final volunteerCoordinatorDashboardScreenControllerProvider =
    NotifierProvider<
      VolunteerCoordinatorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return VolunteerCoordinatorDashboardScreenController();
    });

class VolunteerCoordinatorDashboardScreenController
    extends BaseScaffoldController {}
