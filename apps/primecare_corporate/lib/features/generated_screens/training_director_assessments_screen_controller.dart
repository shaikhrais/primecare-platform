// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorAssessmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorAssessmentsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorAssessmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorAssessmentsScreenController();
    });

class TrainingDirectorAssessmentsScreenController
    extends BaseScaffoldController {}
