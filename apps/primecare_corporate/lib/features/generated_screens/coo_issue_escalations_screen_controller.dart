// Governance - Category: controller | Purpose: Non-executable scaffold for CooIssueEscalationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooIssueEscalationsScreenControllerProvider =
    NotifierProvider<
      CooIssueEscalationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooIssueEscalationsScreenController();
    });

class CooIssueEscalationsScreenController extends BaseScaffoldController {}
