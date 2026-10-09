// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorMaterialsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingCoordinatorMaterialsScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorMaterialsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorMaterialsScreenController();
    });

class TrainingCoordinatorMaterialsScreenController
    extends BaseScaffoldController {}
