// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorCourseLibraryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorCourseLibraryScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorCourseLibraryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorCourseLibraryScreenController();
    });

class TrainingDirectorCourseLibraryScreenController
    extends BaseScaffoldController {}
