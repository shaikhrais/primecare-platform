// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorCourseLibraryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorCourseLibraryScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorCourseLibraryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorCourseLibraryScreenController();
    });

class TrainingDirectorCourseLibraryScreenController
    extends BaseScaffoldController {}
