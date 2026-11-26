// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final qualityAssuranceReportsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceReportsScreenController();
    });

class QualityAssuranceReportsScreenController extends BaseScaffoldController {}
