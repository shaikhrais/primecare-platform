// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingComplianceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingComplianceScreenControllerProvider =
    NotifierProvider<
      TrainingComplianceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingComplianceScreenController();
    });

class TrainingComplianceScreenController extends BaseScaffoldController {}
