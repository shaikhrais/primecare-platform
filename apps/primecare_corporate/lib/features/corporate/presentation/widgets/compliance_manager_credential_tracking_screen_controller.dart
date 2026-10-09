// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerCredentialTrackingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerCredentialTrackingScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerCredentialTrackingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerCredentialTrackingScreenController();
    });

class ComplianceManagerCredentialTrackingScreenController
    extends BaseScaffoldController {}
