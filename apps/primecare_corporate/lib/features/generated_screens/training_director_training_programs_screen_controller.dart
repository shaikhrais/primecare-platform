// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorTrainingProgramsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorTrainingProgramsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorTrainingProgramsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorTrainingProgramsScreenController();
    });

class TrainingDirectorTrainingProgramsScreenController
    extends BaseScaffoldController {}
