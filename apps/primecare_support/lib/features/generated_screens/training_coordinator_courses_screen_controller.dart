// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorCoursesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingCoordinatorCoursesScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorCoursesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorCoursesScreenController();
    });

class TrainingCoordinatorCoursesScreenController
    extends BaseScaffoldController {}
