// Governance - Category: controller | Purpose: Non-executable scaffold for LeadershipReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final leadershipReportsScreenControllerProvider =
    NotifierProvider<
      LeadershipReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LeadershipReportsScreenController();
    });

class LeadershipReportsScreenController extends BaseScaffoldController {}
