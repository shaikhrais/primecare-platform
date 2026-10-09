// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceComplianceChecksScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final qualityAssuranceComplianceChecksScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceComplianceChecksScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceComplianceChecksScreenController();
    });

class QualityAssuranceComplianceChecksScreenController
    extends BaseScaffoldController {}
