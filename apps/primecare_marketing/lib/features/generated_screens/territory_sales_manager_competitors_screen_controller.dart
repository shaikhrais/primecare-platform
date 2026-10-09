// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerCompetitorsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerCompetitorsScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerCompetitorsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerCompetitorsScreenController();
    });

class TerritorySalesManagerCompetitorsScreenController
    extends BaseScaffoldController {}
