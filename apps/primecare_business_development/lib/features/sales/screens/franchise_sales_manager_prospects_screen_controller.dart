// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerProspectsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseSalesManagerProspectsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerProspectsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerProspectsScreenController();
    });

class FranchiseSalesManagerProspectsScreenController
    extends BaseScaffoldController {}
