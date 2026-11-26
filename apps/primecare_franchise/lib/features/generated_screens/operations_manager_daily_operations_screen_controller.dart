// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerDailyOperationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final operationsManagerDailyOperationsScreenControllerProvider =
    NotifierProvider<
      OperationsManagerDailyOperationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerDailyOperationsScreenController();
    });

class OperationsManagerDailyOperationsScreenController
    extends BaseScaffoldController {}
