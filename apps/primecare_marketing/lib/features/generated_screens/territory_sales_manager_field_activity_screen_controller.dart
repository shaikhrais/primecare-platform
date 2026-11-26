// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerFieldActivityScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerFieldActivityScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerFieldActivityScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerFieldActivityScreenController();
    });

class TerritorySalesManagerFieldActivityScreenController
    extends BaseScaffoldController {}
