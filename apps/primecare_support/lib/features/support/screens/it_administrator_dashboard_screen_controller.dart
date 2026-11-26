// Governance - Category: controller | Purpose: Non-executable scaffold for ItAdministratorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final itAdministratorDashboardScreenControllerProvider =
    NotifierProvider<
      ItAdministratorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ItAdministratorDashboardScreenController();
    });

class ItAdministratorDashboardScreenController extends BaseScaffoldController {}
