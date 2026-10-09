// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerAuditsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerAuditsScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerAuditsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerAuditsScreenController();
    });

class ComplianceManagerAuditsScreenController extends BaseScaffoldController {}
