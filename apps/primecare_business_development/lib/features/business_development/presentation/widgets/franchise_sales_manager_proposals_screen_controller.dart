// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerProposalsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseSalesManagerProposalsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerProposalsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerProposalsScreenController();
    });

class FranchiseSalesManagerProposalsScreenController
    extends BaseScaffoldController {}
