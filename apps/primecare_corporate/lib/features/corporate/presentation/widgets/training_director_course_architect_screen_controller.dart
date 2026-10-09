// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorCourseArchitectScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorCourseArchitectScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorCourseArchitectScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorCourseArchitectScreenController();
    });

class TrainingDirectorCourseArchitectScreenController
    extends BaseScaffoldController {}
