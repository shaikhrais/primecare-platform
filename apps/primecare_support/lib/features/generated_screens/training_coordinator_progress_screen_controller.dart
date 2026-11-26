// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorProgressScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingCoordinatorProgressScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorProgressScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorProgressScreenController();
    });

class TrainingCoordinatorProgressScreenController
    extends BaseScaffoldController {}
