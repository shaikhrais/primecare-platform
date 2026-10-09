// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerCorrectiveActionsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerCorrectiveActionsScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerCorrectiveActionsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerCorrectiveActionsScreenController();
    });

class ComplianceManagerCorrectiveActionsScreenController
    extends BaseScaffoldController {}
