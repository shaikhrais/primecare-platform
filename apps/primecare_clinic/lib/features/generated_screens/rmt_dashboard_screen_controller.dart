// Governance - Category: controller | Purpose: Non-executable scaffold for RmtDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final rmtDashboardScreenControllerProvider =
    NotifierProvider<
      RmtDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RmtDashboardScreenController();
    });

class RmtDashboardScreenController extends BaseScaffoldController {}
