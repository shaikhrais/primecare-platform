// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingCoordinatorReportsScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorReportsScreenController();
    });

class TrainingCoordinatorReportsScreenController
    extends BaseScaffoldController {}
