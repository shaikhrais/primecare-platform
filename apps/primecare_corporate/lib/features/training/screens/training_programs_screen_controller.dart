// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingProgramsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingProgramsScreenControllerProvider =
    NotifierProvider<
      TrainingProgramsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingProgramsScreenController();
    });

class TrainingProgramsScreenController extends BaseScaffoldController {}
