// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerLeadsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territorySalesManagerLeadsScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerLeadsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerLeadsScreenController();
    });

class TerritorySalesManagerLeadsScreenController
    extends BaseScaffoldController {}
