// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorStaffTrainingMatrixScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorStaffTrainingMatrixScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorStaffTrainingMatrixScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorStaffTrainingMatrixScreenController();
    });

class TrainingDirectorStaffTrainingMatrixScreenController
    extends BaseScaffoldController {}
