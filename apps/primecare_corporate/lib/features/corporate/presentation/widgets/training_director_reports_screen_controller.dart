// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorReportsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorReportsScreenController();
    });

class TrainingDirectorReportsScreenController extends BaseScaffoldController {}
