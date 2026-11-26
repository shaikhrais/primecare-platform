// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerComplianceCasesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceManagerComplianceCasesScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerComplianceCasesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerComplianceCasesScreenController();
    });

class ComplianceManagerComplianceCasesScreenController
    extends BaseScaffoldController {}
