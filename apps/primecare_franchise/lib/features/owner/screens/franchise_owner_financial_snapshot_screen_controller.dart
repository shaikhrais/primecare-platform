// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerFinancialSnapshotScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseOwnerFinancialSnapshotScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerFinancialSnapshotScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerFinancialSnapshotScreenController();
    });

class FranchiseOwnerFinancialSnapshotScreenController
    extends BaseScaffoldController {}
