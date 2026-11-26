// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmFranchisePipelineScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalBdmFranchisePipelineScreenControllerProvider =
    NotifierProvider<
      RegionalBdmFranchisePipelineScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmFranchisePipelineScreenController();
    });

class RegionalBdmFranchisePipelineScreenController
    extends BaseScaffoldController {}
