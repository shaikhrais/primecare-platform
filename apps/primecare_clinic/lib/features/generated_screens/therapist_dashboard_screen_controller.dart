// Governance - Category: controller | Purpose: Non-executable scaffold for TherapistDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final therapistDashboardScreenControllerProvider =
    NotifierProvider<
      TherapistDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TherapistDashboardScreenController();
    });

class TherapistDashboardScreenController extends BaseScaffoldController {}
