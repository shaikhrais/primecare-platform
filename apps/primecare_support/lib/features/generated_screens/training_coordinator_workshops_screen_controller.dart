// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorWorkshopsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingCoordinatorWorkshopsScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorWorkshopsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorWorkshopsScreenController();
    });

class TrainingCoordinatorWorkshopsScreenController
    extends BaseScaffoldController {}
