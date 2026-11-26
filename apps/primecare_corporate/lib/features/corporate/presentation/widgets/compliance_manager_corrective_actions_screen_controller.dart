// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerCorrectiveActionsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceManagerCorrectiveActionsScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerCorrectiveActionsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerCorrectiveActionsScreenController();
    });

class ComplianceManagerCorrectiveActionsScreenController
    extends BaseScaffoldController {}
