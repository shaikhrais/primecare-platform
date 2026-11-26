// Governance - Category: controller | Purpose: Non-executable scaffold for CeoGrowthPipelineScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ceoGrowthPipelineScreenControllerProvider =
    NotifierProvider<
      CeoGrowthPipelineScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoGrowthPipelineScreenController();
    });

class CeoGrowthPipelineScreenController extends BaseScaffoldController {}
