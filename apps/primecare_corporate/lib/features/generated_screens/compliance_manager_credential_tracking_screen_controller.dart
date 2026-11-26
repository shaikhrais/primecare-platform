// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerCredentialTrackingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceManagerCredentialTrackingScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerCredentialTrackingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerCredentialTrackingScreenController();
    });

class ComplianceManagerCredentialTrackingScreenController
    extends BaseScaffoldController {}
