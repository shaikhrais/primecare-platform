// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerReportsScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerReportsScreenController();
    });

class ComplianceManagerReportsScreenController extends BaseScaffoldController {}
