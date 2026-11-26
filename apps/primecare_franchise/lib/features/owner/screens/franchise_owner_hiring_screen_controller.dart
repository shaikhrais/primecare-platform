// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerHiringScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseOwnerHiringScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerHiringScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerHiringScreenController();
    });

class FranchiseOwnerHiringScreenController extends BaseScaffoldController {}
