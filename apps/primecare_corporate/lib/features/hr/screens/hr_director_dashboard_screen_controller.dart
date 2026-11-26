// Governance - Category: controller | Purpose: Non-executable scaffold for HrDirectorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final hrDirectorDashboardScreenControllerProvider =
    NotifierProvider<
      HrDirectorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrDirectorDashboardScreenController();
    });

class HrDirectorDashboardScreenController extends BaseScaffoldController {}
