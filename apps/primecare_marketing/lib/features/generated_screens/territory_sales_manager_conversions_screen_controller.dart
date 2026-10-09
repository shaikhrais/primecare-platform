// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerConversionsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerConversionsScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerConversionsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerConversionsScreenController();
    });

class TerritorySalesManagerConversionsScreenController
    extends BaseScaffoldController {}
