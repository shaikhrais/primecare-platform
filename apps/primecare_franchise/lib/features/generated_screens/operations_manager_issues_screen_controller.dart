// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerIssuesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final operationsManagerIssuesScreenControllerProvider =
    NotifierProvider<
      OperationsManagerIssuesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerIssuesScreenController();
    });

class OperationsManagerIssuesScreenController extends BaseScaffoldController {}
