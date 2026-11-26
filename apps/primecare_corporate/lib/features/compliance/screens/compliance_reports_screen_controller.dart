// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceReportsScreenControllerProvider =
    NotifierProvider<
      ComplianceReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceReportsScreenController();
    });

class ComplianceReportsScreenController extends BaseScaffoldController {}
