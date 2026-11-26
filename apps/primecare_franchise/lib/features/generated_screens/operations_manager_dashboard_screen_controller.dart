// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final operationsManagerDashboardScreenControllerProvider =
    NotifierProvider<
      OperationsManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerDashboardScreenController();
    });

class OperationsManagerDashboardScreenController
    extends BaseScaffoldController {}
