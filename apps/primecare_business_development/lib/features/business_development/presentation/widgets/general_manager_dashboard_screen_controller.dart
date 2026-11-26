// Governance - Category: controller | Purpose: Non-executable scaffold for GeneralManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final generalManagerDashboardScreenControllerProvider =
    NotifierProvider<
      GeneralManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return GeneralManagerDashboardScreenController();
    });

class GeneralManagerDashboardScreenController extends BaseScaffoldController {}
