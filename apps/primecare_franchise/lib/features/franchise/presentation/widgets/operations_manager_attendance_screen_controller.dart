// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerAttendanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final operationsManagerAttendanceScreenControllerProvider =
    NotifierProvider<
      OperationsManagerAttendanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerAttendanceScreenController();
    });

class OperationsManagerAttendanceScreenController
    extends BaseScaffoldController {}
