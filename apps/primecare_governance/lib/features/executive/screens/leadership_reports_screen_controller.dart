// Governance - Category: controller | Purpose: Non-executable scaffold for LeadershipReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final leadershipReportsScreenControllerProvider =
    NotifierProvider<
      LeadershipReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LeadershipReportsScreenController();
    });

class LeadershipReportsScreenController extends BaseScaffoldController {}
