// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerContractsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseSalesManagerContractsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerContractsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerContractsScreenController();
    });

class FranchiseSalesManagerContractsScreenController
    extends BaseScaffoldController {}
