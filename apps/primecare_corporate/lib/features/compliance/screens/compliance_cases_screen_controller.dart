// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceCasesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceCasesScreenControllerProvider =
    NotifierProvider<
      ComplianceCasesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceCasesScreenController();
    });

class ComplianceCasesScreenController extends BaseScaffoldController {}
