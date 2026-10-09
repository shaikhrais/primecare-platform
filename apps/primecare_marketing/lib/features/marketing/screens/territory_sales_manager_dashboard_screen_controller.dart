// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerDashboardScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerDashboardScreenController();
    });

class TerritorySalesManagerDashboardScreenController
    extends BaseScaffoldController {}
