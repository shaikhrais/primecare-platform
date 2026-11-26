// Governance - Category: controller | Purpose: Non-executable scaffold for ChiropractorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final chiropractorDashboardScreenControllerProvider =
    NotifierProvider<
      ChiropractorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ChiropractorDashboardScreenController();
    });

class ChiropractorDashboardScreenController extends BaseScaffoldController {}
