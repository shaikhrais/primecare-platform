// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final qualityAssuranceDashboardScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceDashboardScreenController();
    });

class QualityAssuranceDashboardScreenController
    extends BaseScaffoldController {}
