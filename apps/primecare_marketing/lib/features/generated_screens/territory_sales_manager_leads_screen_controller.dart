// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerLeadsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerLeadsScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerLeadsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerLeadsScreenController();
    });

class TerritorySalesManagerLeadsScreenController
    extends BaseScaffoldController {}
