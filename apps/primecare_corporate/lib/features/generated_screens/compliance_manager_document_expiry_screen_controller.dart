// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceManagerDocumentExpiryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceManagerDocumentExpiryScreenControllerProvider =
    NotifierProvider<
      ComplianceManagerDocumentExpiryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceManagerDocumentExpiryScreenController();
    });

class ComplianceManagerDocumentExpiryScreenController
    extends BaseScaffoldController {}
