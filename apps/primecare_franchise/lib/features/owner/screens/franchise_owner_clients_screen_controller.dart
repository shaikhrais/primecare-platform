// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerClientsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerClientsScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerClientsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerClientsScreenController();
    });

class FranchiseOwnerClientsScreenController extends BaseScaffoldController {}
