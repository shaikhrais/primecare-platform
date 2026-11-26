// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorTrainerAssignmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorTrainerAssignmentsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorTrainerAssignmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorTrainerAssignmentsScreenController();
    });

class TrainingDirectorTrainerAssignmentsScreenController
    extends BaseScaffoldController {}
