// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingCoordinatorDashboardScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorDashboardScreenController();
    });

class TrainingCoordinatorDashboardScreenController
    extends BaseScaffoldController {}
