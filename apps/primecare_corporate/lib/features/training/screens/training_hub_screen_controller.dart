// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingHubScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingHubScreenControllerProvider =
    NotifierProvider<
      TrainingHubScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingHubScreenController();
    });

class TrainingHubScreenController extends BaseScaffoldController {}
