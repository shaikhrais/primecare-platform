// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerReportsScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerReportsScreenController();
    });

class FranchiseOwnerReportsScreenController extends BaseScaffoldController {}
