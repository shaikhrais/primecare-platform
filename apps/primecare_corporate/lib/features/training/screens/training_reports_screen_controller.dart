// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingReportsScreenControllerProvider =
    NotifierProvider<
      TrainingReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingReportsScreenController();
    });

class TrainingReportsScreenController extends BaseScaffoldController {}
