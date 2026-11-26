// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceAuditsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final qualityAssuranceAuditsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceAuditsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceAuditsScreenController();
    });

class QualityAssuranceAuditsScreenController extends BaseScaffoldController {}
