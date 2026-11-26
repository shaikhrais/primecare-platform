// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerPoliciesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceManagerPoliciesScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerPoliciesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerPoliciesScreenController();
    });

class ComplianceManagerPoliciesScreenController
    extends BaseScaffoldController {}
