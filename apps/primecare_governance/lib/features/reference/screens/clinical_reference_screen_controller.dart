// Governance - Category: controller | Purpose: Non-executable scaffold for ClinicalReferenceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clinicalReferenceScreenControllerProvider =
    NotifierProvider<
      ClinicalReferenceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClinicalReferenceScreenController();
    });

class ClinicalReferenceScreenController extends BaseScaffoldController {}
