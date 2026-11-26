// Governance - Category: controller | Purpose: Non-executable scaffold for TerritorySalesManagerPipelineScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final territorySalesManagerPipelineScreenControllerProvider =
    NotifierProvider<
      TerritorySalesManagerPipelineScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TerritorySalesManagerPipelineScreenController();
    });

class TerritorySalesManagerPipelineScreenController
    extends BaseScaffoldController {}
