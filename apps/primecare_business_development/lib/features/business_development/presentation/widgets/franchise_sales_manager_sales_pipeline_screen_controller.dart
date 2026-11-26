// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerSalesPipelineScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseSalesManagerSalesPipelineScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerSalesPipelineScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerSalesPipelineScreenController();
    });

class FranchiseSalesManagerSalesPipelineScreenController
    extends BaseScaffoldController {}
