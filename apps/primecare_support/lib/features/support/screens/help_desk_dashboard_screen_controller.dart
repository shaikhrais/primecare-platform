// Governance - Category: controller | Purpose: Non-executable scaffold for HelpDeskDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final helpDeskDashboardScreenControllerProvider =
    NotifierProvider<
      HelpDeskDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HelpDeskDashboardScreenController();
    });

class HelpDeskDashboardScreenController extends BaseScaffoldController {}
