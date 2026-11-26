// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingPerformanceReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final headOfMarketingPerformanceReportsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingPerformanceReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingPerformanceReportsScreenController();
    });

class HeadOfMarketingPerformanceReportsScreenController
    extends BaseScaffoldController {}
