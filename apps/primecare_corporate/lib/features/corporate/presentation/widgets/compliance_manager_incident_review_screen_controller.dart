// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerIncidentReviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceManagerIncidentReviewScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerIncidentReviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerIncidentReviewScreenController();
    });

class ComplianceManagerIncidentReviewScreenController
    extends BaseScaffoldController {}
