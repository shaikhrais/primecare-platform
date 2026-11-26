// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorMaterialsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingCoordinatorMaterialsScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorMaterialsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorMaterialsScreenController();
    });

class TrainingCoordinatorMaterialsScreenController
    extends BaseScaffoldController {}
