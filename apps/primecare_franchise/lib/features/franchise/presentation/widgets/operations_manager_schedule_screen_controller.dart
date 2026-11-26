// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerScheduleScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final operationsManagerScheduleScreenControllerProvider =
    NotifierProvider<
      OperationsManagerScheduleScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerScheduleScreenController();
    });

class OperationsManagerScheduleScreenController
    extends BaseScaffoldController {}
