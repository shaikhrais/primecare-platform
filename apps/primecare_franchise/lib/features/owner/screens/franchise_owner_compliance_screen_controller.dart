// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerComplianceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerComplianceScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerComplianceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerComplianceScreenController();
    });

class FranchiseOwnerComplianceScreenController extends BaseScaffoldController {}
