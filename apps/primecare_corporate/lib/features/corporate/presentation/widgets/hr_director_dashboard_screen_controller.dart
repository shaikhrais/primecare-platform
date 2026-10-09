// Governance - Category: controller | Purpose: Non-executable scaffold for HrDirectorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrDirectorDashboardScreenControllerProvider =
    NotifierProvider<
      HrDirectorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrDirectorDashboardScreenController();
    });

class HrDirectorDashboardScreenController extends BaseScaffoldController {}
