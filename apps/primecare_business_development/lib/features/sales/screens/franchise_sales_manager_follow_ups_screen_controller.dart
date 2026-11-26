// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerFollowUpsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseSalesManagerFollowUpsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerFollowUpsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerFollowUpsScreenController();
    });

class FranchiseSalesManagerFollowUpsScreenController
    extends BaseScaffoldController {}
