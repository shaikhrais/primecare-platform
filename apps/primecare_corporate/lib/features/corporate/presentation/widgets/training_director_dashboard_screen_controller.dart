// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorDashboardScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorDashboardScreenController();
    });

class TrainingDirectorDashboardScreenController
    extends BaseScaffoldController {}
