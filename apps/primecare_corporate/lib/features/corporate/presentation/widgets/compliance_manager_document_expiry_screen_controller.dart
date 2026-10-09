// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerDocumentExpiryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final complianceManagerDocumentExpiryScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerDocumentExpiryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerDocumentExpiryScreenController();
    });

class ComplianceManagerDocumentExpiryScreenController
    extends BaseScaffoldController {}
