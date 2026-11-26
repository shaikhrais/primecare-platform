// Governance - Category: controller | Purpose: Non-executable scaffold for QualityMetricsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final qualityMetricsScreenControllerProvider =
    NotifierProvider<
      QualityMetricsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityMetricsScreenController();
    });

class QualityMetricsScreenController extends BaseScaffoldController {}
