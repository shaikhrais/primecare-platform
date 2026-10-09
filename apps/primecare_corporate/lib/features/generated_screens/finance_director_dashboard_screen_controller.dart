// Governance - Category: controller | Purpose: Non-executable scaffold for FinanceDirectorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final financeDirectorDashboardScreenControllerProvider =
    NotifierProvider<
      FinanceDirectorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FinanceDirectorDashboardScreenController();
    });

class FinanceDirectorDashboardScreenController extends BaseScaffoldController {}
