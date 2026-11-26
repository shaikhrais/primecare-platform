// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerStaffCoordinationScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final operationsManagerStaffCoordinationScreenControllerProvider =
    NotifierProvider<
      OperationsManagerStaffCoordinationScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerStaffCoordinationScreenController();
    });

class OperationsManagerStaffCoordinationScreenController
    extends BaseScaffoldController {}
