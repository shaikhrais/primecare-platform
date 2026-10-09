// Governance - Category: controller | Purpose: Non-executable scaffold for ItAdminDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final itAdminDashboardScreenControllerProvider =
    NotifierProvider<
      ItAdminDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ItAdminDashboardScreenController();
    });

class ItAdminDashboardScreenController extends BaseScaffoldController {}
