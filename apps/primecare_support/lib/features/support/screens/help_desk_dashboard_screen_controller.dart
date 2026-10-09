// Governance - Category: controller | Purpose: Non-executable scaffold for HelpDeskDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final helpDeskDashboardScreenControllerProvider =
    NotifierProvider<
      HelpDeskDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HelpDeskDashboardScreenController();
    });

class HelpDeskDashboardScreenController extends BaseScaffoldController {}
