// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final intakeCoordinatorDashboardScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorDashboardScreenController();
    });

class IntakeCoordinatorDashboardScreenController
    extends BaseScaffoldController {}
