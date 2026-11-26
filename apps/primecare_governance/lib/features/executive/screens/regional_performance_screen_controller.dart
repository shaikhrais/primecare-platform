// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalPerformanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalPerformanceScreenControllerProvider =
    NotifierProvider<
      RegionalPerformanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalPerformanceScreenController();
    });

class RegionalPerformanceScreenController extends BaseScaffoldController {}
