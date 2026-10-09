// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerStaffScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerStaffScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerStaffScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerStaffScreenController();
    });

class FranchiseOwnerStaffScreenController extends BaseScaffoldController {}
