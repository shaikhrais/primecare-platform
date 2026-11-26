// Governance - Category: controller | Purpose: Non-executable scaffold for GovernanceHudScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final governanceHudScreenControllerProvider =
    NotifierProvider<
      GovernanceHudScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return GovernanceHudScreenController();
    });

class GovernanceHudScreenController extends BaseScaffoldController {}
