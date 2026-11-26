// Governance - Category: controller | Purpose: Non-executable scaffold for PhysiotherapistDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final physiotherapistDashboardScreenControllerProvider =
    NotifierProvider<
      PhysiotherapistDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PhysiotherapistDashboardScreenController();
    });

class PhysiotherapistDashboardScreenController extends BaseScaffoldController {}
