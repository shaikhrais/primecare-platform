// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmFranchisePipelineScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmFranchisePipelineScreenControllerProvider =
    NotifierProvider<
      RegionalBdmFranchisePipelineScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmFranchisePipelineScreenController();
    });

class RegionalBdmFranchisePipelineScreenController
    extends BaseScaffoldController {}
