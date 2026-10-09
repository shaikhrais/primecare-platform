// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorComplianceTrainingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorComplianceTrainingScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorComplianceTrainingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorComplianceTrainingScreenController();
    });

class TrainingDirectorComplianceTrainingScreenController
    extends BaseScaffoldController {}
