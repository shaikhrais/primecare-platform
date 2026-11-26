// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final intakeCoordinatorDashboardScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorDashboardScreenController();
    });

class IntakeCoordinatorDashboardScreenController
    extends BaseScaffoldController {}
