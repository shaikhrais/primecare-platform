// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseSalesManagerReportsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerReportsScreenController();
    });

class FranchiseSalesManagerReportsScreenController
    extends BaseScaffoldController {}
