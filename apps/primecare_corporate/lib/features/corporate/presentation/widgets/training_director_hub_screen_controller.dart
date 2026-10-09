// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorHubScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorHubScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorHubScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorHubScreenController();
    });

class TrainingDirectorHubScreenController extends BaseScaffoldController {}
