// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final operationsManagerReportsScreenControllerProvider =
    NotifierProvider<
      OperationsManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerReportsScreenController();
    });

class OperationsManagerReportsScreenController extends BaseScaffoldController {}
