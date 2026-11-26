// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorCourseArchitectScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorCourseArchitectScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorCourseArchitectScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorCourseArchitectScreenController();
    });

class TrainingDirectorCourseArchitectScreenController
    extends BaseScaffoldController {}
