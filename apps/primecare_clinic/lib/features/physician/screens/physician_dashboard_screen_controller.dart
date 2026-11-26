// Governance - Category: controller | Purpose: Non-executable scaffold for PhysicianDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final physicianDashboardScreenControllerProvider =
    NotifierProvider<
      PhysicianDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PhysicianDashboardScreenController();
    });

class PhysicianDashboardScreenController extends BaseScaffoldController {}
