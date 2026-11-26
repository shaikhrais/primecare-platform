// Governance - Category: controller | Purpose: Non-executable scaffold for CaregiverDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final caregiverDashboardScreenControllerProvider =
    NotifierProvider<
      CaregiverDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CaregiverDashboardScreenController();
    });

class CaregiverDashboardScreenController extends BaseScaffoldController {}
