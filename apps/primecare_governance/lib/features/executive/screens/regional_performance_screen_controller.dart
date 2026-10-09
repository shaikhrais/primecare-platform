// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalPerformanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalPerformanceScreenControllerProvider =
    NotifierProvider<
      RegionalPerformanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalPerformanceScreenController();
    });

class RegionalPerformanceScreenController extends BaseScaffoldController {}
