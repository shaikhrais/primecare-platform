// Governance - Category: controller | Purpose: Non-executable scaffold for RpnDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final rpnDashboardScreenControllerProvider =
    NotifierProvider<
      RpnDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RpnDashboardScreenController();
    });

class RpnDashboardScreenController extends BaseScaffoldController {}
