// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceTrainingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceTrainingScreenControllerProvider =
    NotifierProvider<
      ComplianceTrainingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceTrainingScreenController();
    });

class ComplianceTrainingScreenController extends BaseScaffoldController {}
