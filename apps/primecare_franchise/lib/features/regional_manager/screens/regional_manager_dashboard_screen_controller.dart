// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalManagerDashboardScreenControllerProvider =
    NotifierProvider<
      RegionalManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalManagerDashboardScreenController();
    });

class RegionalManagerDashboardScreenController extends BaseScaffoldController {}
