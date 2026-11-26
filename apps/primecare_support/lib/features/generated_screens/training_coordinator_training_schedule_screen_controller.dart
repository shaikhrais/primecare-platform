// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorTrainingScheduleScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingCoordinatorTrainingScheduleScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorTrainingScheduleScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorTrainingScheduleScreenController();
    });

class TrainingCoordinatorTrainingScheduleScreenController
    extends BaseScaffoldController {}
