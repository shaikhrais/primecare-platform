// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerRiskRegisterScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerRiskRegisterScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerRiskRegisterScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerRiskRegisterScreenController();
    });

class ComplianceManagerRiskRegisterScreenController
    extends BaseScaffoldController {}
