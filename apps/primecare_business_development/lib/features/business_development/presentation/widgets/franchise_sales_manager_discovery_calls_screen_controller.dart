// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseSalesManagerDiscoveryCallsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseSalesManagerDiscoveryCallsScreenControllerProvider =
    NotifierProvider<
      FranchiseSalesManagerDiscoveryCallsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseSalesManagerDiscoveryCallsScreenController();
    });

class FranchiseSalesManagerDiscoveryCallsScreenController
    extends BaseScaffoldController {}
