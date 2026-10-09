// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerProspectsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseSalesManagerProspectsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerProspectsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerProspectsScreenController();
    });

class FranchiseSalesManagerProspectsScreenController
    extends BaseScaffoldController {}
