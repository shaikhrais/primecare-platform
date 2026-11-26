// Governance - Category: controller | Purpose: Non-executable scaffold for ClinicalReferenceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clinicalReferenceScreenControllerProvider =
    NotifierProvider<
      ClinicalReferenceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClinicalReferenceScreenController();
    });

class ClinicalReferenceScreenController extends BaseScaffoldController {}
