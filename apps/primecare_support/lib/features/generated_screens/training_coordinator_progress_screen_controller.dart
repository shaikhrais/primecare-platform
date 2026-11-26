// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorProgressScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingCoordinatorProgressScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorProgressScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorProgressScreenController();
    });

class TrainingCoordinatorProgressScreenController
    extends BaseScaffoldController {}
