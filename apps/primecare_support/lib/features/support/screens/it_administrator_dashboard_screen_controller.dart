// Governance - Category: controller | Purpose: Non-executable scaffold for ItAdministratorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final itAdministratorDashboardScreenControllerProvider =
    NotifierProvider<
      ItAdministratorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ItAdministratorDashboardScreenController();
    });

class ItAdministratorDashboardScreenController extends BaseScaffoldController {}
