// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorTrainingProgramsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorTrainingProgramsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorTrainingProgramsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorTrainingProgramsScreenController();
    });

class TrainingDirectorTrainingProgramsScreenController
    extends BaseScaffoldController {}
