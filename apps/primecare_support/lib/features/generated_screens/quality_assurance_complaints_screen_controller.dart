// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceComplaintsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final qualityAssuranceComplaintsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceComplaintsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceComplaintsScreenController();
    });

class QualityAssuranceComplaintsScreenController
    extends BaseScaffoldController {}
