// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerAttendanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final operationsManagerAttendanceScreenControllerProvider =
    NotifierProvider<
      OperationsManagerAttendanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerAttendanceScreenController();
    });

class OperationsManagerAttendanceScreenController
    extends BaseScaffoldController {}
