// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerBranchOverviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerBranchOverviewScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerBranchOverviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerBranchOverviewScreenController();
    });

class FranchiseOwnerBranchOverviewScreenController
    extends BaseScaffoldController {}
