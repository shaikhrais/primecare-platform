// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerPipelineScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final territorySalesManagerPipelineScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerPipelineScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerPipelineScreenController();
    });

class TerritorySalesManagerPipelineScreenController
    extends BaseScaffoldController {}
