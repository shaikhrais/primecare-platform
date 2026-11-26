// Governance - Category: controller | Purpose: Non-executable scaffold for HrManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final hrManagerDashboardScreenControllerProvider =
    NotifierProvider<
      HrManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrManagerDashboardScreenController();
    });

class HrManagerDashboardScreenController extends BaseScaffoldController {}
