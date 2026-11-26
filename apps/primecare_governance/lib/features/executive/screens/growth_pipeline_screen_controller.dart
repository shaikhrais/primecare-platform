// Governance - Category: controller | Purpose: Non-executable scaffold for GrowthPipelineScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final growthPipelineScreenControllerProvider =
    NotifierProvider<
      GrowthPipelineScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return GrowthPipelineScreenController();
    });

class GrowthPipelineScreenController extends BaseScaffoldController {}
