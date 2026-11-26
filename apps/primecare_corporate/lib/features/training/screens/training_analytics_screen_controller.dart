// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingAnalyticsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingAnalyticsScreenControllerProvider =
    NotifierProvider<
      TrainingAnalyticsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingAnalyticsScreenController();
    });

class TrainingAnalyticsScreenController extends BaseScaffoldController {}
