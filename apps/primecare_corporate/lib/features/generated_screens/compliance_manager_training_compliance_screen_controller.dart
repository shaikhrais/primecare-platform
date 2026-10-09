// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerTrainingComplianceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerTrainingComplianceScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerTrainingComplianceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerTrainingComplianceScreenController();
    });

class ComplianceManagerTrainingComplianceScreenController
    extends BaseScaffoldController {}
