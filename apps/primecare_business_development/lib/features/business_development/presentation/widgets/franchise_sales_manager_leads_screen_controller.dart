// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerLeadsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseSalesManagerLeadsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerLeadsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerLeadsScreenController();
    });

class FranchiseSalesManagerLeadsScreenController
    extends BaseScaffoldController {}
