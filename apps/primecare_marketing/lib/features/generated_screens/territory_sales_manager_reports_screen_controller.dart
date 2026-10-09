// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerReportsScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerReportsScreenController();
    });

class TerritorySalesManagerReportsScreenController
    extends BaseScaffoldController {}
