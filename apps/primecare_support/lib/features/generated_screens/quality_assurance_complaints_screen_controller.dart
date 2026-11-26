// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceComplaintsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final qualityAssuranceComplaintsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceComplaintsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceComplaintsScreenController();
    });

class QualityAssuranceComplaintsScreenController
    extends BaseScaffoldController {}
