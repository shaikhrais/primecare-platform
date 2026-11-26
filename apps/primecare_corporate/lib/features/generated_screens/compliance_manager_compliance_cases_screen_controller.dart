// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerComplianceCasesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerComplianceCasesScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerComplianceCasesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerComplianceCasesScreenController();
    });

class ComplianceManagerComplianceCasesScreenController
    extends BaseScaffoldController {}
