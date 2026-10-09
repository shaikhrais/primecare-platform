// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerShiftsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final operationsManagerShiftsScreenControllerProvider =
    NotifierProvider<
      OperationsManagerShiftsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerShiftsScreenController();
    });

class OperationsManagerShiftsScreenController extends BaseScaffoldController {}
