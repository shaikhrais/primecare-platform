// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorTrainerAssignmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorTrainerAssignmentsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorTrainerAssignmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorTrainerAssignmentsScreenController();
    });

class TrainingDirectorTrainerAssignmentsScreenController
    extends BaseScaffoldController {}
