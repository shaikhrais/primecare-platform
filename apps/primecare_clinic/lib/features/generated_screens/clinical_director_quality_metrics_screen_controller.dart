// Governance - Category: controller | Purpose: Non-executable scaffold for ClinicalDirectorQualityMetricsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clinicalDirectorQualityMetricsScreenControllerProvider =
    NotifierProvider<
      ClinicalDirectorQualityMetricsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClinicalDirectorQualityMetricsScreenController();
    });

class ClinicalDirectorQualityMetricsScreenController
    extends BaseScaffoldController {}
