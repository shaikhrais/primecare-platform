// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerPoliciesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerPoliciesScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerPoliciesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerPoliciesScreenController();
    });

class ComplianceManagerPoliciesScreenController
    extends BaseScaffoldController {}
