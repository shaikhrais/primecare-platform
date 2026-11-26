// Governance - Category: controller | Purpose: Non-executable scaffold for InfectionControlDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final infectionControlDashboardScreenControllerProvider =
    NotifierProvider<
      InfectionControlDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return InfectionControlDashboardScreenController();
    });

class InfectionControlDashboardScreenController
    extends BaseScaffoldController {}
