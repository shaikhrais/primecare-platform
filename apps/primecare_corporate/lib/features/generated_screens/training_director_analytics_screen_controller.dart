// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorAnalyticsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingDirectorAnalyticsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorAnalyticsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorAnalyticsScreenController();
    });

class TrainingDirectorAnalyticsScreenController
    extends BaseScaffoldController {}
