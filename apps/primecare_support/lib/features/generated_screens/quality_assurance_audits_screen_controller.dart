// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceAuditsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final qualityAssuranceAuditsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceAuditsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceAuditsScreenController();
    });

class QualityAssuranceAuditsScreenController extends BaseScaffoldController {}
