// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerFollowUpsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseSalesManagerFollowUpsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerFollowUpsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerFollowUpsScreenController();
    });

class FranchiseSalesManagerFollowUpsScreenController
    extends BaseScaffoldController {}
