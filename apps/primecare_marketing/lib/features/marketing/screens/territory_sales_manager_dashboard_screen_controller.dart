// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territorySalesManagerDashboardScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerDashboardScreenController();
    });

class TerritorySalesManagerDashboardScreenController
    extends BaseScaffoldController {}
