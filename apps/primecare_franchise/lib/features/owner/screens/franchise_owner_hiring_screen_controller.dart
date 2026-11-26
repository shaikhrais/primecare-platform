// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerHiringScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerHiringScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerHiringScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerHiringScreenController();
    });

class FranchiseOwnerHiringScreenController extends BaseScaffoldController {}
