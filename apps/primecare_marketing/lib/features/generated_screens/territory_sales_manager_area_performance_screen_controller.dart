// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerAreaPerformanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerAreaPerformanceScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerAreaPerformanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerAreaPerformanceScreenController();
    });

class TerritorySalesManagerAreaPerformanceScreenController
    extends BaseScaffoldController {}
