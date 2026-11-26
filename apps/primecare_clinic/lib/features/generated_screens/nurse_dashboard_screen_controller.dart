// Governance - Category: controller | Purpose: Non-executable scaffold for NurseDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final nurseDashboardScreenControllerProvider =
    NotifierProvider<
      NurseDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return NurseDashboardScreenController();
    });

class NurseDashboardScreenController extends BaseScaffoldController {}
