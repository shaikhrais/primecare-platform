// Governance - Category: controller | Purpose: Non-executable scaffold for RmtDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final rmtDashboardScreenControllerProvider =
    NotifierProvider<
      RmtDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RmtDashboardScreenController();
    });

class RmtDashboardScreenController extends BaseScaffoldController {}
