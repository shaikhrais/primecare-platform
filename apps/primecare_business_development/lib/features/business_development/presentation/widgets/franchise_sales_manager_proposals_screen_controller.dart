// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerProposalsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseSalesManagerProposalsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerProposalsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerProposalsScreenController();
    });

class FranchiseSalesManagerProposalsScreenController
    extends BaseScaffoldController {}
