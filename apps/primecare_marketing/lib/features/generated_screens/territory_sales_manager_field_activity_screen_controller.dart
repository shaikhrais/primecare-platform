// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerFieldActivityScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territorySalesManagerFieldActivityScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerFieldActivityScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerFieldActivityScreenController();
    });

class TerritorySalesManagerFieldActivityScreenController
    extends BaseScaffoldController {}
