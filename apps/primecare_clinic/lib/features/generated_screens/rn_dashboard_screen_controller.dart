// Governance - Category: controller | Purpose: Non-executable scaffold for RnDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final rnDashboardScreenControllerProvider =
    NotifierProvider<
      RnDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RnDashboardScreenController();
    });

class RnDashboardScreenController extends BaseScaffoldController {}
